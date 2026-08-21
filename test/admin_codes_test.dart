import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:wren/src/admin_codes.dart';
import 'package:wren/src/comp_unlock.dart';

/// Tests for the code console's half of the conversation.
///
/// The transport is injected, so none of this reaches the Worker. What is
/// checked here is what the app does with an answer: that a role is read as
/// sent rather than guessed, that a refusal is told apart from a network that
/// is not there, and that the request carries the token that authorises it.
/// Whether the Worker is right to have answered that way is checked in
/// `server/comp-codes-worker/test`.
void main() {
  /// Records what was asked, and replies with what the test says.
  ({List<String> calls, AdminTransport transport}) recording(
    int status,
    String body,
  ) {
    final calls = <String>[];
    return (
      calls: calls,
      transport: (method, url, headers, requestBody) async {
        calls.add(
          '$method ${url.path} ${headers['authorization']} $requestBody',
        );
        return (status: status, body: body);
      },
    );
  }

  AdminTransport replying(int status, String body) =>
      (_, _, _, _) async => (status: status, body: body);

  group('list', () {
    test('reads a code as the server described it', () async {
      final codes = await AdminCodes(
        'tok',
        transport: replying(
          200,
          jsonEncode({
            'codes': [
              {
                'code': 'ABCD-EFGH-JKMN-PQRS',
                'note': 'App Review',
                'role': 'unlock',
                'uses': 3,
                'maxUses': 500,
                'revoked': false,
                'spent': false,
                'expiresAt': null,
              },
            ],
          }),
        ),
      ).list();

      expect(codes, hasLength(1));
      expect(codes.single.code, 'ABCD-EFGH-JKMN-PQRS');
      expect(codes.single.role, CompRole.unlock);
      expect(codes.single.uses, 3);
      expect(codes.single.live, isTrue);
    });

    test('an admin code is shown as one', () async {
      final codes = await AdminCodes(
        'tok',
        transport: replying(
          200,
          jsonEncode({
            'codes': [
              {'code': 'A', 'role': 'admin', 'uses': 0, 'maxUses': 1},
            ],
          }),
        ),
      ).list();
      expect(codes.single.role, CompRole.admin);
    });

    test('a role nobody recognises is listed as an ordinary unlock', () async {
      // The listing must not invent authority the server did not grant. A row
      // that guessed 'admin' would be a lie about who can issue codes.
      for (final claimed in ['ADMIN', 'owner', '', null]) {
        final codes = await AdminCodes(
          'tok',
          transport: replying(
            200,
            jsonEncode({
              'codes': [
                {'code': 'A', 'role': claimed, 'uses': 0, 'maxUses': 1},
              ],
            }),
          ),
        ).list();
        expect(codes.single.role, CompRole.unlock, reason: 'role "$claimed"');
      }
    });

    test('a spent or withdrawn code is not live', () async {
      final codes = await AdminCodes(
        'tok',
        transport: replying(
          200,
          jsonEncode({
            'codes': [
              {'code': 'A', 'uses': 1, 'maxUses': 1, 'spent': true},
              {'code': 'B', 'uses': 0, 'maxUses': 1, 'revoked': true},
              {'code': 'C', 'uses': 0, 'maxUses': 1, 'expiresAt': 1},
              {'code': 'D', 'uses': 0, 'maxUses': 1},
            ],
          }),
        ),
      ).list();
      expect(codes.map((c) => c.live), [false, false, false, true]);
    });

    test('presents the token that authorises the request', () async {
      final probe = recording(200, jsonEncode({'codes': []}));
      await AdminCodes('the-token', transport: probe.transport).list();
      expect(probe.calls.single, contains('Bearer the-token'));
      expect(probe.calls.single, startsWith('GET /admin/codes'));
    });
  });

  group('mint', () {
    test('asks for the role it was given, and returns the codes', () async {
      final probe = recording(
        200,
        jsonEncode({
          'codes': ['AAAA-BBBB', 'CCCC-DDDD'],
        }),
      );
      final minted = await AdminCodes(
        'tok',
        transport: probe.transport,
      ).mint(role: CompRole.admin, count: 2, maxUses: 3, note: 'a friend');
      expect(minted, ['AAAA-BBBB', 'CCCC-DDDD']);
      expect(probe.calls.single, contains('"role":"admin"'));
      expect(probe.calls.single, contains('"count":2'));
      expect(probe.calls.single, contains('"maxUses":3'));
    });

    test('an unlock is asked for by name rather than by omission', () async {
      // The server defaults an absent or unrecognised role to 'unlock', but a
      // client that relied on that would be one renamed field away from
      // issuing administrators by accident.
      final probe = recording(
        200,
        jsonEncode({
          'codes': ['A'],
        }),
      );
      await AdminCodes(
        'tok',
        transport: probe.transport,
      ).mint(role: CompRole.unlock);
      expect(probe.calls.single, contains('"role":"unlock"'));
    });

    test('refuses to ask for a code that grants nothing', () async {
      expect(
        () => AdminCodes(
          'tok',
          transport: replying(200, '{}'),
        ).mint(role: CompRole.none),
        throwsArgumentError,
      );
    });
  });

  group('revoke', () {
    test('names the code and nothing else', () async {
      final probe = recording(200, jsonEncode({'revoked': true}));
      await AdminCodes('tok', transport: probe.transport).revoke('AAAA-BBBB');
      expect(probe.calls.single, startsWith('POST /admin/revoke'));
      expect(probe.calls.single, contains('"code":"AAAA-BBBB"'));
    });

    test(
      'withdrawing the code this device is using is reported as such',
      () async {
        // Not "forbidden": the difference between "you may not do this" and "you
        // may not do this to yourself" is the difference between a device that
        // has lost the console and one that still has it.
        await expectLater(
          AdminCodes(
            'tok',
            transport: replying(
              409,
              jsonEncode({'error': 'would_revoke_self'}),
            ),
          ).revoke('AAAA-BBBB'),
          throwsA(
            isA<AdminException>().having(
              (e) => e.failure,
              'failure',
              AdminFailure.wouldRevokeSelf,
            ),
          ),
        );
      },
    );
  });

  group('failures', () {
    Future<AdminFailure> failureOf(AdminTransport transport) async {
      try {
        await AdminCodes('tok', transport: transport).list();
      } on AdminException catch (e) {
        return e.failure;
      }
      fail('the call did not fail');
    }

    test('a refused token is not the same as an unreachable server', () async {
      // Conflating them sends someone looking for a new code when their train
      // went into a tunnel.
      expect(await failureOf(replying(403, '{}')), AdminFailure.notPermitted);
      expect(
        await failureOf((_, _, _, _) => throw const _NoNetwork()),
        AdminFailure.unreachable,
      );
    });

    test('an answer that is not the shape promised is unreadable', () async {
      expect(
        await failureOf(replying(200, 'not json')),
        AdminFailure.unreadable,
      );
      expect(
        await failureOf(replying(200, jsonEncode({'codes': 'nope'}))),
        AdminFailure.unreadable,
      );
      expect(await failureOf(replying(500, '{}')), AdminFailure.unreadable);
    });
  });
}

class _NoNetwork implements Exception {
  const _NoNetwork();
}
