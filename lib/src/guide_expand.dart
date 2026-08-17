/// Turns Apple's short guide link into the one that carries a payload.
///
/// Sharing a guide from Apple Maps gives `maps.apple/ug/<opaque id>`. There is
/// nothing in it to decode — the places live behind a 301 to
/// `maps.apple.com/guides?user=<payload>`. So the only way to read a guide the
/// user actually shared is to ask Apple where the short link points.
///
/// This is the second thing in the app that touches the network, after
/// redeeming a complimentary code, and it is worth being precise about what it
/// sends: one request to Apple, containing a link the user pasted themselves and
/// nothing else. No place data, no identifier, no account. The redirect target
/// is read from the `location` header and the body is never fetched.
///
/// Redirects are deliberately **not** followed. Following one would download an
/// Apple Maps web page for no reason; the header is the whole answer.
library;

import 'dart:io';

class LinkExpandFailed implements Exception {
  final String message;

  /// True when the network could not be reached at all, as opposed to Apple
  /// answering with something unexpected. The UI says different things for the
  /// two, because one is worth retrying and the other is not.
  final bool offline;

  LinkExpandFailed(this.message, {this.offline = false});
  @override
  String toString() => 'LinkExpandFailed: $message';
}

abstract class LinkExpander {
  /// Returns the URL a short link points at. Throws [LinkExpandFailed] rather
  /// than returning null, so a failure cannot be mistaken for "no redirect".
  Future<String> expand(String shortLink);
}

class HttpLinkExpander implements LinkExpander {
  HttpLinkExpander({Duration? timeout})
    : timeout = timeout ?? const Duration(seconds: 12);

  final Duration timeout;

  /// Apple's short-link hosts. Checked before any request is made, so a pasted
  /// link cannot make this app fetch an arbitrary URL.
  static const _allowedHosts = {'maps.apple', 'maps.apple.com'};

  @override
  Future<String> expand(String shortLink) async {
    final uri = Uri.tryParse(shortLink.trim());
    if (uri == null || !_allowedHosts.contains(uri.host.toLowerCase())) {
      throw LinkExpandFailed('not an Apple Maps link');
    }

    final client = HttpClient()..connectionTimeout = timeout;
    try {
      final request = await client.headUrl(uri).timeout(timeout);
      // The point of the exercise: read the header, do not chase it.
      request.followRedirects = false;
      request.headers.set(HttpHeaders.userAgentHeader, 'Wren');
      final response = await request.close().timeout(timeout);
      await response.drain<void>();

      final location = response.headers.value(HttpHeaders.locationHeader);
      if (response.statusCode < 300 || response.statusCode >= 400) {
        throw LinkExpandFailed(
          'that link did not redirect (HTTP ${response.statusCode})',
        );
      }
      if (location == null || location.isEmpty) {
        throw LinkExpandFailed('that link redirected to nothing');
      }
      return location;
    } on SocketException catch (e) {
      throw LinkExpandFailed(e.message, offline: true);
    } on HttpException catch (e) {
      throw LinkExpandFailed(e.message, offline: true);
    } finally {
      client.close(force: true);
    }
  }
}

/// Returns a fixed target, so the import flow can be tested without a network.
class StubLinkExpander implements LinkExpander {
  StubLinkExpander(this.target);

  /// The URL to return, or null to fail as though offline.
  final String? target;

  @override
  Future<String> expand(String shortLink) async {
    final t = target;
    if (t == null) throw LinkExpandFailed('no network', offline: true);
    return t;
  }
}
