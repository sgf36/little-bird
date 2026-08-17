import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:wren/src/guide_expand.dart';

/// Exercises the short-link expander against a server that behaves the way
/// Apple's actually does.
///
/// The bug this exists to prevent shipped once: the expander sent **HEAD**, and
/// Apple's short-link service answers HEAD with 404 and GET with the 301. A
/// perfectly good guide link therefore reported "that link did not redirect",
/// which the UI rendered as "not an Apple Maps guide link" — sending the user to
/// hunt for a link that does not exist.
///
/// A unit test could not have caught it, because the fault was in a real
/// service's behaviour rather than in logic. A fake server that reproduces that
/// behaviour can, which is the point of the first test here.
void main() {
  late HttpServer server;
  late List<String> methodsSeen;

  /// A stand-in for maps.apple: 404 to HEAD, 301 to GET, exactly as measured.
  Future<Uri> serve({
    required String location,
    int getStatus = 301,
    bool headIs404 = true,
  }) async {
    methodsSeen = [];
    server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    server.listen((req) async {
      methodsSeen.add(req.method);
      if (req.method == 'HEAD' && headIs404) {
        req.response.statusCode = 404;
      } else {
        req.response.statusCode = getStatus;
        if (getStatus >= 300 && getStatus < 400) {
          req.response.headers.set(HttpHeaders.locationHeader, location);
        }
      }
      req.response.headers.contentType = ContentType.text;
      await req.response.close();
    });
    addTearDown(() => server.close(force: true));
    return Uri.parse('http://127.0.0.1:${server.port}/ug/abc123');
  }

  /// The expander only trusts Apple's hosts, so a loopback URL has to be let
  /// through explicitly for a test. Same code path otherwise.
  HttpLinkExpander expander() =>
      HttpLinkExpander(allowAnyHost: true, timeout: const Duration(seconds: 5));

  test('expands via GET, because HEAD is answered with 404', () async {
    const target = 'https://maps.apple.com/guides?user=CgZMb25kb24';
    final uri = await serve(location: target);

    expect(await expander().expand(uri.toString()), target);
    // The assertion that matters: no HEAD was attempted, so a 404 to HEAD can
    // never again be mistaken for a link that is not a guide.
    expect(methodsSeen, ['GET']);
  });

  test('a redirect with no location is refused', () async {
    final uri = await serve(location: '', getStatus: 302);
    await expectLater(
      expander().expand(uri.toString()),
      throwsA(isA<LinkExpandFailed>()),
    );
  });

  test('a 200 is not a redirect and says so', () async {
    final uri = await serve(location: 'x', getStatus: 200);
    await expectLater(
      expander().expand(uri.toString()),
      throwsA(
        predicate(
          (e) =>
              e is LinkExpandFailed && e.message.contains('did not redirect'),
        ),
      ),
    );
  });

  test('a host that is not Apple is refused before any request', () async {
    // A pasted link decides what gets fetched, so the host is checked first.
    // Refused without a request, which is why this does not need a server.
    await expectLater(
      HttpLinkExpander().expand('https://example.com/ug/abc'),
      throwsA(isA<LinkExpandFailed>()),
    );
    await expectLater(
      HttpLinkExpander().expand('maps.apple.evil.example.com/ug/abc'),
      throwsA(isA<LinkExpandFailed>()),
    );
  });

  test(
    'an unreachable host reports itself as offline, not as a bad link',
    () async {
      // The distinction the UI depends on: one is worth retrying, the other sends
      // the user looking for a different link.
      final e = await expander()
          .expand('http://127.0.0.1:1/ug/abc')
          .then<Object?>((_) => null)
          .onError<LinkExpandFailed>((e, _) => e);
      expect(e, isA<LinkExpandFailed>());
      expect((e as LinkExpandFailed).offline, isTrue);
    },
  );
}
