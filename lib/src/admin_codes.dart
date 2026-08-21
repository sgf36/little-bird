/// Issuing and withdrawing complimentary codes from inside the app.
///
/// Codes have always been minted with curl and the operator's shared token.
/// That is fine at a desk and useless in a conversation, which is where a code
/// is actually given away — so this is the same three calls, reachable from a
/// phone, authorised by a code rather than by a password.
///
/// What authorises a request here is the very token the device was given when
/// it redeemed an admin code: `comp.heldToken()`, presented as a bearer. It is
/// not a second credential and there is nothing extra to keep safe. The server
/// verifies the signature, then re-reads the code's role from its own table
/// before doing anything, so an administrator can be withdrawn — which an
/// unlock, checked offline for ever, never can be.
///
/// Nothing in here is reachable without that token, and nothing in the
/// interface mentions it: a device holding an ordinary unlock, or no unlock at
/// all, never constructs this class. See `admin_sheet.dart`.
library;

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'comp_unlock.dart' show CompRole, compEndpoint;

/// Why a request did not do what was asked.
enum AdminFailure {
  /// The server declined the token. Either the code has been withdrawn, or it
  /// was never an admin code. Indistinguishable on purpose, upstream.
  notPermitted,

  /// The code named is the one this device is using. Revoking it would sign
  /// this phone out of the console with nothing on screen to explain why.
  wouldRevokeSelf,

  /// No network, or the server could not be reached.
  unreachable,

  /// Reached and answered, and the answer made no sense.
  unreadable,
}

class AdminException implements Exception {
  final AdminFailure failure;
  const AdminException(this.failure);

  @override
  String toString() => 'AdminException(${failure.name})';
}

/// One row of the code list.
class CodeRecord {
  /// Grouped for reading aloud — the server hyphenates, this does not re-do it.
  final String code;
  final String note;
  final CompRole role;
  final int uses;
  final int maxUses;
  final bool revoked;
  final bool spent;
  final DateTime? expiresAt;

  const CodeRecord({
    required this.code,
    required this.note,
    required this.role,
    required this.uses,
    required this.maxUses,
    required this.revoked,
    required this.spent,
    this.expiresAt,
  });

  /// Whether the code would still be accepted if someone typed it now.
  bool get live =>
      !revoked &&
      !spent &&
      (expiresAt == null || expiresAt!.isAfter(DateTime.now()));

  factory CodeRecord.fromJson(Map<String, dynamic> m) {
    final expires = m['expiresAt'];
    return CodeRecord(
      code: (m['code'] ?? '').toString(),
      note: (m['note'] ?? '').toString(),
      // Anything unrecognised is an unlock, matching the server. A listing
      // that guessed 'admin' would be a lie about who can issue codes.
      role: m['role'] == 'admin' ? CompRole.admin : CompRole.unlock,
      uses: (m['uses'] as num?)?.toInt() ?? 0,
      maxUses: (m['maxUses'] as num?)?.toInt() ?? 1,
      revoked: m['revoked'] == true,
      spent: m['spent'] == true,
      expiresAt: expires is num
          ? DateTime.fromMillisecondsSinceEpoch(expires.toInt() * 1000)
          : null,
    );
  }
}

/// One HTTP call, injected so tests never reach the network.
typedef AdminTransport =
    Future<({int status, String body})> Function(
      String method,
      Uri url,
      Map<String, String> headers,
      String? body,
    );

Future<({int status, String body})> _send(
  String method,
  Uri url,
  Map<String, String> headers,
  String? body,
) async {
  final client = HttpClient()..connectionTimeout = const Duration(seconds: 10);
  try {
    final request = await client.openUrl(method, url);
    headers.forEach(request.headers.set);
    if (body != null) {
      request.headers.contentType = ContentType.json;
      request.write(body);
    }
    final response = await request.close().timeout(const Duration(seconds: 15));
    return (
      status: response.statusCode,
      body: await response.transform(utf8.decoder).join(),
    );
  } finally {
    client.close(force: true);
  }
}

class AdminCodes {
  /// The signed token this device holds, from `comp.heldToken()`.
  final String token;

  final AdminTransport _transport;

  AdminCodes(this.token, {@visibleForTesting AdminTransport? transport})
    : _transport = transport ?? _send;

  Map<String, String> get _headers => {'authorization': 'Bearer $token'};

  Future<Map<String, dynamic>> _call(
    String method,
    String path, [
    Map<String, dynamic>? body,
  ]) async {
    final ({int status, String body}) reply;
    try {
      reply = await _transport(
        method,
        Uri.parse('$compEndpoint$path'),
        _headers,
        body == null ? null : jsonEncode(body),
      );
    } catch (_) {
      return throw const AdminException(AdminFailure.unreachable);
    }
    if (reply.status == 409) {
      throw const AdminException(AdminFailure.wouldRevokeSelf);
    }
    if (reply.status == 403 || reply.status == 401) {
      throw const AdminException(AdminFailure.notPermitted);
    }
    if (reply.status != 200) {
      throw const AdminException(AdminFailure.unreadable);
    }
    try {
      return jsonDecode(reply.body) as Map<String, dynamic>;
    } catch (_) {
      throw const AdminException(AdminFailure.unreadable);
    }
  }

  /// Every code ever issued, newest first, with how far each has been used.
  Future<List<CodeRecord>> list() async {
    final body = await _call('GET', '/admin/codes');
    final rows = body['codes'];
    if (rows is! List) throw const AdminException(AdminFailure.unreadable);
    try {
      return rows
          .cast<Map<String, dynamic>>()
          .map(CodeRecord.fromJson)
          .toList(growable: false);
    } catch (_) {
      throw const AdminException(AdminFailure.unreadable);
    }
  }

  /// Issues codes and returns them. This is the only moment they are readable:
  /// the server stores what it needs to recognise them, and the list shows
  /// them again, but a code that is never written down is nobody's.
  Future<List<String>> mint({
    required CompRole role,
    int count = 1,
    int maxUses = 1,
    String note = '',
  }) async {
    if (role == CompRole.none) {
      throw ArgumentError('a code grants something or it is not a code');
    }
    final body = await _call('POST', '/admin/codes', {
      'count': count,
      'maxUses': maxUses,
      'note': note,
      'role': role == CompRole.admin ? 'admin' : 'unlock',
    });
    final codes = body['codes'];
    if (codes is! List) throw const AdminException(AdminFailure.unreadable);
    return codes.map((c) => c.toString()).toList(growable: false);
  }

  /// Stops a code being redeemed again.
  ///
  /// It does not reach anyone who has already redeemed it: they hold a signed
  /// token and keep the unlock. What it does take back is the console, because
  /// that is decided against the table on every request.
  Future<void> revoke(String code) async {
    await _call('POST', '/admin/revoke', {'code': code});
  }
}
