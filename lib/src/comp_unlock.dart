/// Complimentary access: a code that unlocks the paid feature once, for one
/// person, without a payment.
///
/// It replaces a single code compiled into the build. That version had two
/// faults that mattered. Everyone shared one code, so one leak unlocked the app
/// for anyone who saw it and the only remedy was shipping a new build; and the
/// code arrived through `--dart-define` from a CI secret, so rotating it meant
/// a release.
///
/// Why a server is involved at all, given the app otherwise has none: single
/// use cannot be decided on the device. A code could be signed and verified
/// offline against an embedded public key — no network, unlimited codes — but
/// nothing on a phone can know that a code has already been spent on a
/// different phone. "Already redeemed" is a fact with exactly one home.
///
/// The network is touched once, when a code is entered. What comes back is an
/// Ed25519-signed token naming this device, kept locally and checked offline
/// from then on. Two consequences worth having: the app never phones home at
/// launch, and pointing it at a look-alike server gains nothing, because a
/// forged approval cannot carry a valid signature.
library;

import 'dart:convert';
import 'dart:io';

import 'package:cryptography/cryptography.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Overridable so a build can be pointed at a local Worker during development.
const String _endpoint = String.fromEnvironment(
  'WREN_CODES_URL',
  defaultValue: 'https://wren-codes.sgf36.workers.dev',
);

/// The verifying half of the Worker's signing pair. Public by definition and
/// committed on purpose: it is what lets the app judge a token by itself
/// rather than trusting whatever answered the request.
const String _publicKeyBase64 = 'LN6bVyBTvZgcov3ElAo5JtlrUy02BYKZUgBxMVtq3Ys=';

const _tokenKey = 'comp_token';
const _channel = MethodChannel('littlebird/identity');

enum RedeemOutcome {
  /// Accepted. The entitlement is stored and holds from now on.
  unlocked,

  /// Wrong, already spent, revoked or expired. The server does not say which,
  /// and neither does this: distinguishing them would confirm to a stranger
  /// that a code they hold is real.
  refused,

  /// Too many failed attempts from this address.
  toooften,

  /// No network, or the server could not be reached.
  unreachable,

  /// Reached, answered, and the answer did not verify. Either something is
  /// broken or something is pretending to be the server.
  untrusted,
}

/// Injectable for tests, which must not reach the network.
typedef Sender =
    Future<({int status, String body})> Function(Uri url, String body);

Future<({int status, String body})> _send(Uri url, String body) async {
  final client = HttpClient()..connectionTimeout = const Duration(seconds: 10);
  try {
    final request = await client.postUrl(url);
    request.headers.contentType = ContentType.json;
    request.write(body);
    final response = await request.close().timeout(const Duration(seconds: 15));
    return (
      status: response.statusCode,
      body: await response.transform(utf8.decoder).join(),
    );
  } finally {
    client.close(force: true);
  }
}

Future<String?> _deviceId() async {
  try {
    return await _channel.invokeMethod<String>('deviceId');
  } on MissingPluginException {
    return null; // Not iOS. Nothing to redeem against.
  } on PlatformException {
    return null;
  }
}

List<int> _fromBase64Url(String s) =>
    base64Url.decode(s.padRight((s.length + 3) & ~3, '='));

/// Checks the signature and that the token was issued to *this* device.
///
/// The device id is inside the signed payload, so a token copied off someone
/// else's phone fails here rather than granting a second unlock from one code.
Future<bool> _tokenIsGood(
  String token,
  String device, [
  String? publicKey,
]) async {
  final parts = token.split('.');
  if (parts.length != 2) return false;
  try {
    final payload = _fromBase64Url(parts[0]);
    final signature = _fromBase64Url(parts[1]);
    final key = SimplePublicKey(
      base64.decode(publicKey ?? _publicKeyBase64),
      type: KeyPairType.ed25519,
    );
    final valid = await Ed25519().verify(
      payload,
      signature: Signature(signature, publicKey: key),
    );
    if (!valid) return false;
    final claims = jsonDecode(utf8.decode(payload)) as Map<String, dynamic>;
    return claims['d'] == device;
  } catch (_) {
    return false;
  }
}

/// Sends a code, and on success stores the token it gets back.
Future<RedeemOutcome> redeem(
  String entered, {
  @visibleForTesting Sender? send,
  @visibleForTesting String? device,
  @visibleForTesting String? publicKey,
}) async {
  final code = entered.trim();
  if (code.isEmpty) return RedeemOutcome.refused;

  final id = device ?? await _deviceId();
  if (id == null) return RedeemOutcome.unreachable;

  final ({int status, String body}) reply;
  try {
    reply = await (send ?? _send)(
      Uri.parse('$_endpoint/redeem'),
      jsonEncode({'code': code, 'device': id}),
    );
  } catch (_) {
    return RedeemOutcome.unreachable;
  }

  if (reply.status == 429) return RedeemOutcome.toooften;
  if (reply.status != 200) return RedeemOutcome.refused;

  final String token;
  try {
    token = (jsonDecode(reply.body) as Map<String, dynamic>)['token'] as String;
  } catch (_) {
    return RedeemOutcome.untrusted;
  }

  // Verified before it is stored. A 200 is not proof of anything on its own.
  if (!await _tokenIsGood(token, id, publicKey)) {
    return RedeemOutcome.untrusted;
  }

  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_tokenKey, token);
  return RedeemOutcome.unlocked;
}

/// Whether this device holds a valid complimentary unlock. Offline, every time
/// after the first.
///
/// Re-verified on each launch rather than trusted as a stored boolean, so a
/// flag written into app storage by hand is not an unlock.
Future<bool> wasUnlocked({
  @visibleForTesting String? device,
  @visibleForTesting String? publicKey,
}) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString(_tokenKey);
  if (token == null) return false;
  final id = device ?? await _deviceId();
  if (id == null) return false;
  if (await _tokenIsGood(token, id, publicKey)) return true;
  // Not ours, or not genuine. Drop it rather than keep asking.
  await prefs.remove(_tokenKey);
  return false;
}
