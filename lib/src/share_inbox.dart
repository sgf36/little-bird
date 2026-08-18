import 'package:flutter/services.dart';

/// Guide links arriving from the iOS share sheet.
///
/// Wren appears in Apple Maps' share sheet through a share extension. That
/// extension runs in its own process and is gone before the app opens, so it
/// leaves the URL in a shared container and this collects it.
///
/// Collect, not read: the native side deletes the file before returning it, so a
/// failed import cannot turn into the same link importing on every launch.
///
/// Returns null when there is nothing waiting, which is almost always, and also
/// when the App Group is missing — that has to be created by hand in the
/// developer portal, since the App Store Connect API has no such resource. A
/// missing group degrades to "no link waiting" rather than to a broken app.
abstract class ShareInbox {
  Future<String?> take();
}

class MethodChannelShareInbox implements ShareInbox {
  const MethodChannelShareInbox();

  static const _channel = MethodChannel('littlebird/share');

  @override
  Future<String?> take() async {
    try {
      return await _channel.invokeMethod<String>('take');
    } on MissingPluginException {
      // Not iOS, or an older build of the app shell. Not an error.
      return null;
    } on PlatformException {
      return null;
    }
  }
}

/// Hands back whatever it was given, once. For tests and for platforms with no
/// share sheet.
class StubShareInbox implements ShareInbox {
  StubShareInbox([this._pending]);

  String? _pending;

  @override
  Future<String?> take() async {
    final v = _pending;
    _pending = null;
    return v;
  }
}
