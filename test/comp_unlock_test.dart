import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wren/src/comp_unlock.dart';

/// Tests for complimentary unlock codes.
///
/// The network is injected, so none of this reaches the Worker. What is being
/// checked here is the half that runs on the phone: that a signed token is
/// believed, and that everything else is not. The server's own guarantee —
/// that a one-use code is spent exactly once even under simultaneous
/// redemptions — is checked against the deployed Worker, not here.
void main() {
  late SimpleKeyPair keys;
  late SimpleKeyPair otherKeys;
  late String publicKey;
  late String otherPublicKey;

  setUpAll(() async {
    keys = await Ed25519().newKeyPair();
    publicKey = base64.encode((await keys.extractPublicKey()).bytes);
    otherKeys = await Ed25519().newKeyPair();
    otherPublicKey = base64.encode((await otherKeys.extractPublicKey()).bytes);
  });

  setUp(() => SharedPreferences.setMockInitialValues({}));

  /// The moment every token in these tests is issued, and the clock they are
  /// judged against. Fixed, because a token's age is the whole subject here
  /// and `DateTime.now()` would make the answers drift.
  final issued = DateTime.utc(2026, 8, 21, 12);

  /// A token exactly as the Worker builds one.
  Future<String> tokenFor(String device, {String? role, DateTime? at}) async {
    final payload = utf8.encode(
      jsonEncode({
        'v': 1,
        'd': device,
        'c': 'TESTCODE',
        'r': ?role,
        't': (at ?? issued).millisecondsSinceEpoch ~/ 1000,
      }),
    );
    final signature = await Ed25519().sign(payload, keyPair: keys);
    String url(List<int> b) => base64Url.encode(b).replaceAll('=', '');
    return '${url(payload)}.${url(signature.bytes)}';
  }

  /// The same token, signed by a pair the app does not trust. Stands in for a
  /// look-alike server answering a renewal.
  Future<String> forgedTokenFor(
    String device, {
    String? role,
    DateTime? at,
  }) async {
    final payload = utf8.encode(
      jsonEncode({
        'v': 1,
        'd': device,
        'c': 'TESTCODE',
        'r': ?role,
        't': (at ?? issued).millisecondsSinceEpoch ~/ 1000,
      }),
    );
    final signature = await Ed25519().sign(payload, keyPair: otherKeys);
    String url(List<int> b) => base64Url.encode(b).replaceAll('=', '');
    return '${url(payload)}.${url(signature.bytes)}';
  }

  Sender replying(int status, String body) =>
      (_, _) async => (status: status, body: body);

  group('redeem', () {
    test('accepts a properly signed token and remembers it', () async {
      final token = await tokenFor('device-A');
      final outcome = await redeem(
        'ABCD-EFGH',
        send: replying(200, jsonEncode({'token': token})),
        device: 'device-A',
        publicKey: publicKey,
      );
      expect(outcome, RedeemOutcome.unlocked);
      expect(
        await wasUnlocked(device: 'device-A', publicKey: publicKey),
        isTrue,
      );
    });

    test('rejects a token signed by anything but the Worker', () async {
      // The point of the signature. A server that answers "yes" is not
      // sufficient — a proxy or a look-alike host can do that.
      final token = await tokenFor('device-A');
      final outcome = await redeem(
        'ABCD-EFGH',
        send: replying(200, jsonEncode({'token': token})),
        device: 'device-A',
        publicKey: otherPublicKey,
      );
      expect(outcome, RedeemOutcome.untrusted);
      expect(
        await wasUnlocked(device: 'device-A', publicKey: publicKey),
        isFalse,
      );
    });

    test('rejects a token issued to a different device', () async {
      // A friend's token, copied across. One code, one phone.
      final token = await tokenFor('device-A');
      final outcome = await redeem(
        'ABCD-EFGH',
        send: replying(200, jsonEncode({'token': token})),
        device: 'device-B',
        publicKey: publicKey,
      );
      expect(outcome, RedeemOutcome.untrusted);
    });

    test('a 403 is refused without saying why', () async {
      final outcome = await redeem(
        'ABCD-EFGH',
        send: replying(403, jsonEncode({'error': 'invalid_code'})),
        device: 'device-A',
        publicKey: publicKey,
      );
      expect(outcome, RedeemOutcome.refused);
    });

    test('a 429 is reported as rate limiting, not as a bad code', () async {
      final outcome = await redeem(
        'ABCD-EFGH',
        send: replying(429, jsonEncode({'error': 'rate_limited'})),
        device: 'device-A',
        publicKey: publicKey,
      );
      expect(outcome, RedeemOutcome.toooften);
    });

    test('a network failure is not a wrong code', () async {
      // Telling someone their code is invalid when the aeroplane wifi dropped
      // sends them to look for a new code they do not need.
      final outcome = await redeem(
        'ABCD-EFGH',
        send: (_, _) => throw const SocketishFailure(),
        device: 'device-A',
        publicKey: publicKey,
      );
      expect(outcome, RedeemOutcome.unreachable);
    });

    test('nonsense in place of a token does not unlock', () async {
      final outcome = await redeem(
        'ABCD-EFGH',
        send: replying(200, 'not json at all'),
        device: 'device-A',
        publicKey: publicKey,
      );
      expect(outcome, RedeemOutcome.untrusted);
    });

    test('an empty code never reaches the network', () async {
      var called = false;
      final outcome = await redeem(
        '   ',
        send: (_, _) async {
          called = true;
          return (status: 200, body: '{}');
        },
        device: 'device-A',
        publicKey: publicKey,
      );
      expect(outcome, RedeemOutcome.refused);
      expect(called, isFalse);
    });
  });

  group('wasUnlocked', () {
    test('is false with nothing stored', () async {
      expect(
        await wasUnlocked(device: 'device-A', publicKey: publicKey),
        isFalse,
      );
    });

    test('a hand-written value in storage is not an unlock', () async {
      SharedPreferences.setMockInitialValues({'comp_token': 'i-am-unlocked'});
      expect(
        await wasUnlocked(device: 'device-A', publicKey: publicKey),
        isFalse,
      );
    });

    test('a token belonging to another device is discarded', () async {
      SharedPreferences.setMockInitialValues({
        'comp_token': await tokenFor('device-A'),
      });
      expect(
        await wasUnlocked(device: 'device-B', publicKey: publicKey),
        isFalse,
      );
      // Dropped, so it is not re-checked on every launch for ever.
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('comp_token'), isNull);
    });

    test('a token with no role at all is still an unlock', () async {
      // Every token issued before roles existed looks like this. They must go
      // on working, and they must not read as administrators.
      SharedPreferences.setMockInitialValues({
        'comp_token': await tokenFor('device-A'),
      });
      expect(
        await wasUnlocked(device: 'device-A', publicKey: publicKey),
        isTrue,
      );
      expect(
        await heldRole(device: 'device-A', publicKey: publicKey),
        CompRole.unlock,
      );
    });

    test('holds across restarts without the network', () async {
      SharedPreferences.setMockInitialValues({
        'comp_token': await tokenFor('device-A'),
      });
      for (var launch = 0; launch < 3; launch++) {
        expect(
          await wasUnlocked(device: 'device-A', publicKey: publicKey),
          isTrue,
        );
      }
    });
  });

  group('heldRole', () {
    test('nothing stored grants nothing', () async {
      expect(
        await heldRole(device: 'device-A', publicKey: publicKey),
        CompRole.none,
      );
    });

    test('an admin code grants the console as well as the unlock', () async {
      SharedPreferences.setMockInitialValues({
        'comp_token': await tokenFor('device-A', role: 'admin'),
      });
      expect(
        await heldRole(device: 'device-A', publicKey: publicKey),
        CompRole.admin,
      );
      expect(
        await wasUnlocked(device: 'device-A', publicKey: publicKey),
        isTrue,
      );
    });

    test('an ordinary code grants only the unlock', () async {
      SharedPreferences.setMockInitialValues({
        'comp_token': await tokenFor('device-A', role: 'unlock'),
      });
      expect(
        await heldRole(device: 'device-A', publicKey: publicKey),
        CompRole.unlock,
      );
    });

    test('a role nobody recognises is not a promotion', () async {
      // Total by construction: the console is offered for exactly one value
      // and refused for every other, rather than refused for a list of known
      // ones and offered for whatever is left.
      for (final claimed in ['ADMIN', 'administrator', '', 'root']) {
        SharedPreferences.setMockInitialValues({
          'comp_token': await tokenFor('device-A', role: claimed),
        });
        expect(
          await heldRole(device: 'device-A', publicKey: publicKey),
          CompRole.unlock,
          reason: '"$claimed" was read as an administrator',
        );
      }
    });

    test(
      'an admin claim on a token signed by anyone else is worth nothing',
      () async {
        // The claim is inside the signature, so promoting yourself means forging
        // one. This is the whole of why the role travels in the token rather
        // than beside it.
        SharedPreferences.setMockInitialValues({
          'comp_token': await tokenFor('device-A', role: 'admin'),
        });
        expect(
          await heldRole(device: 'device-A', publicKey: otherPublicKey),
          CompRole.none,
        );
      },
    );

    test('a token for another device grants nothing and is dropped', () async {
      SharedPreferences.setMockInitialValues({
        'comp_token': await tokenFor('device-A', role: 'admin'),
      });
      expect(
        await heldRole(device: 'device-B', publicKey: publicKey),
        CompRole.none,
      );
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('comp_token'), isNull);
    });
  });

  group('heldToken', () {
    test('is what the console will present, unchanged', () async {
      final token = await tokenFor('device-A', role: 'admin');
      SharedPreferences.setMockInitialValues({'comp_token': token});
      expect(await heldToken(), token);
    });

    test('is null with nothing stored', () async {
      expect(await heldToken(), isNull);
    });
  });

  group('staleness', () {
    test('an administrator confirmed today holds everything', () async {
      SharedPreferences.setMockInitialValues({
        'comp_token': await tokenFor('device-A', role: 'admin'),
      });
      expect(
        await heldRole(
          device: 'device-A',
          publicKey: publicKey,
          now: issued.add(const Duration(hours: 6)),
        ),
        CompRole.admin,
      );
    });

    test('an administrator unconfirmed past the grace holds nothing', () async {
      // The whole point of the exercise: withdrawing a code has to reach a
      // phone that already redeemed it, and a phone that never asks again
      // cannot be reached at all.
      SharedPreferences.setMockInitialValues({
        'comp_token': await tokenFor('device-A', role: 'admin'),
      });
      expect(
        await heldRole(
          device: 'device-A',
          publicKey: publicKey,
          now: issued.add(compGrace + const Duration(minutes: 1)),
        ),
        CompRole.none,
      );
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('comp_token'), isNull);
    });

    test('an ordinary unlock never goes stale, however old', () async {
      // A code given to a friend is not taken back because they spent a year
      // without opening the app, and their copy of Wren still reaches nothing.
      SharedPreferences.setMockInitialValues({
        'comp_token': await tokenFor('device-A', role: 'unlock'),
      });
      expect(
        await heldRole(
          device: 'device-A',
          publicKey: publicKey,
          now: issued.add(const Duration(days: 900)),
        ),
        CompRole.unlock,
      );
    });

    test('a token from before roles existed never goes stale either', () async {
      SharedPreferences.setMockInitialValues({
        'comp_token': await tokenFor('device-A'),
      });
      expect(
        await heldRole(
          device: 'device-A',
          publicKey: publicKey,
          now: issued.add(const Duration(days: 900)),
        ),
        CompRole.unlock,
      );
    });
  });

  group('compTimeLeft', () {
    test('says nothing while there is nothing to warn about', () async {
      SharedPreferences.setMockInitialValues({
        'comp_token': await tokenFor('device-A', role: 'admin'),
      });
      expect(
        await compTimeLeft(
          device: 'device-A',
          publicKey: publicKey,
          now: issued.add(const Duration(days: 1)),
        ),
        isNull,
      );
    });

    test('warns once the lapse is days away', () async {
      SharedPreferences.setMockInitialValues({
        'comp_token': await tokenFor('device-A', role: 'admin'),
      });
      final left = await compTimeLeft(
        device: 'device-A',
        publicKey: publicKey,
        now: issued.add(compGrace - const Duration(days: 2)),
      );
      expect(left, isNotNull);
      expect(left!.inDays, 2);
    });

    test('never warns an ordinary unlock, which cannot lapse', () async {
      SharedPreferences.setMockInitialValues({
        'comp_token': await tokenFor('device-A', role: 'unlock'),
      });
      expect(
        await compTimeLeft(
          device: 'device-A',
          publicKey: publicKey,
          now: issued.add(const Duration(days: 900)),
        ),
        isNull,
      );
    });

    test('says nothing when no code has ever been entered', () async {
      expect(
        await compTimeLeft(device: 'device-A', publicKey: publicKey),
        isNull,
      );
    });
  });

  group('renewIfDue', () {
    /// Records whether the network was reached at all, which is half of what
    /// these tests are about.
    ({List<String> sent, Sender send}) recording(int status, String body) {
      final sent = <String>[];
      return (
        sent: sent,
        send: (url, requestBody) async {
          sent.add(url.path);
          return (status: status, body: body);
        },
      );
    }

    test('an ordinary unlock never reaches the network', () async {
      // This is the promise the privacy page makes to everybody who is not an
      // administrator: one call, when the code was entered, and never again.
      SharedPreferences.setMockInitialValues({
        'comp_token': await tokenFor('device-A', role: 'unlock'),
      });
      final probe = recording(200, '{}');
      final role = await renewIfDue(
        send: probe.send,
        device: 'device-A',
        publicKey: publicKey,
        now: issued.add(const Duration(days: 400)),
      );
      expect(role, CompRole.unlock);
      expect(probe.sent, isEmpty);
    });

    test('a token with no code entered reaches nothing', () async {
      final probe = recording(200, '{}');
      expect(
        await renewIfDue(
          send: probe.send,
          device: 'device-A',
          publicKey: publicKey,
        ),
        CompRole.none,
      );
      expect(probe.sent, isEmpty);
    });

    test('an administrator confirmed hours ago is left alone', () async {
      SharedPreferences.setMockInitialValues({
        'comp_token': await tokenFor('device-A', role: 'admin'),
      });
      final probe = recording(200, '{}');
      final role = await renewIfDue(
        send: probe.send,
        device: 'device-A',
        publicKey: publicKey,
        now: issued.add(const Duration(hours: 5)),
      );
      expect(role, CompRole.admin);
      expect(probe.sent, isEmpty, reason: 'renewed far more often than daily');
    });

    test(
      'an administrator a day old is renewed, and the fresh token kept',
      () async {
        final old = await tokenFor('device-A', role: 'admin');
        SharedPreferences.setMockInitialValues({'comp_token': old});
        final later = issued.add(const Duration(days: 2));
        final fresh = await tokenFor('device-A', role: 'admin', at: later);
        final role = await renewIfDue(
          send: (_, _) async =>
              (status: 200, body: jsonEncode({'token': fresh})),
          device: 'device-A',
          publicKey: publicKey,
          now: later,
        );
        expect(role, CompRole.admin);
        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getString('comp_token'), fresh);
        // And the clock has been reset, so the warning is gone with it.
        expect(
          await compTimeLeft(
            device: 'device-A',
            publicKey: publicKey,
            now: later,
          ),
          isNull,
        );
      },
    );

    test(
      'a refusal ends the access at once, without waiting out the grace',
      () async {
        // Withdrawing a code should bite within the day for anyone online. The
        // fortnight is for the phone that cannot ask, not for the one that asked
        // and was told no.
        SharedPreferences.setMockInitialValues({
          'comp_token': await tokenFor('device-A', role: 'admin'),
        });
        final role = await renewIfDue(
          send: (_, _) async =>
              (status: 403, body: jsonEncode({'error': 'not_live'})),
          device: 'device-A',
          publicKey: publicKey,
          now: issued.add(const Duration(days: 2)),
        );
        expect(role, CompRole.none);
        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getString('comp_token'), isNull);
      },
    );

    test('an unreachable server changes nothing', () async {
      // An aeroplane is not a withdrawal. The token simply ages, and the
      // grace period is what eventually decides.
      final held = await tokenFor('device-A', role: 'admin');
      SharedPreferences.setMockInitialValues({'comp_token': held});
      final role = await renewIfDue(
        send: (_, _) => throw const SocketishFailure(),
        device: 'device-A',
        publicKey: publicKey,
        now: issued.add(const Duration(days: 2)),
      );
      expect(role, CompRole.admin);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('comp_token'), held);
    });

    test('a reply signed by anything else is treated as no reply', () async {
      // Not as a withdrawal. Otherwise whatever answers first on a hostile
      // network could end an administrator's access by saying so.
      final held = await tokenFor('device-A', role: 'admin');
      SharedPreferences.setMockInitialValues({'comp_token': held});
      final later = issued.add(const Duration(days: 2));
      final forged = await forgedTokenFor('device-A', role: 'admin', at: later);
      final role = await renewIfDue(
        send: (_, _) async =>
            (status: 200, body: jsonEncode({'token': forged})),
        device: 'device-A',
        publicKey: publicKey,
        now: later,
      );
      expect(role, CompRole.admin);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('comp_token'), held, reason: 'kept the forgery');
    });

    test(
      'rubbish in place of a fresh token leaves the old one alone',
      () async {
        final held = await tokenFor('device-A', role: 'admin');
        SharedPreferences.setMockInitialValues({'comp_token': held});
        for (final body in ['not json', '{}', '{"token": 7}']) {
          final role = await renewIfDue(
            send: (_, _) async => (status: 200, body: body),
            device: 'device-A',
            publicKey: publicKey,
            now: issued.add(const Duration(days: 2)),
          );
          expect(role, CompRole.admin, reason: body);
          final prefs = await SharedPreferences.getInstance();
          expect(prefs.getString('comp_token'), held, reason: body);
        }
      },
    );

    test('a token already past the grace is dropped without asking', () async {
      // There is nothing to renew: the server would refuse it, and asking
      // would make a withdrawal look like a network fault.
      SharedPreferences.setMockInitialValues({
        'comp_token': await tokenFor('device-A', role: 'admin'),
      });
      final probe = recording(200, '{}');
      final role = await renewIfDue(
        send: probe.send,
        device: 'device-A',
        publicKey: publicKey,
        now: issued.add(compGrace + const Duration(days: 1)),
      );
      expect(role, CompRole.none);
      expect(probe.sent, isEmpty);
    });

    test('renewal is asked of /renew, not of /redeem', () async {
      // Redeeming spends a use. Renewing must not, and the App Review code
      // would be exhausted in under a week if it did.
      SharedPreferences.setMockInitialValues({
        'comp_token': await tokenFor('device-A', role: 'admin'),
      });
      final probe = recording(200, '{}');
      await renewIfDue(
        send: probe.send,
        device: 'device-A',
        publicKey: publicKey,
        now: issued.add(const Duration(days: 2)),
      );
      expect(probe.sent, ['/renew']);
    });
  });
}

/// Stands in for whatever dart:io throws when there is no network. The type
/// does not matter to the code under test; only that it throws.
class SocketishFailure implements Exception {
  const SocketishFailure();
}
