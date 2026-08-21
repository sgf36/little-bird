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
  late String publicKey;
  late String otherPublicKey;

  setUpAll(() async {
    keys = await Ed25519().newKeyPair();
    publicKey = base64.encode((await keys.extractPublicKey()).bytes);
    final other = await Ed25519().newKeyPair();
    otherPublicKey = base64.encode((await other.extractPublicKey()).bytes);
  });

  setUp(() => SharedPreferences.setMockInitialValues({}));

  /// A token exactly as the Worker builds one.
  Future<String> tokenFor(String device, {String? role}) async {
    final payload = utf8.encode(
      jsonEncode({
        'v': 1,
        'd': device,
        'c': 'TESTCODE',
        'r': ?role,
        't': 1786921210,
      }),
    );
    final signature = await Ed25519().sign(payload, keyPair: keys);
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
}

/// Stands in for whatever dart:io throws when there is no network. The type
/// does not matter to the code under test; only that it throws.
class SocketishFailure implements Exception {
  const SocketishFailure();
}
