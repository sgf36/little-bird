import 'package:flutter_test/flutter_test.dart';
import 'package:wren/src/share_inbox.dart';

/// The handoff from the iOS share sheet.
///
/// Wren appears in Apple Maps' share sheet through a share extension, which runs
/// in its own process and is gone before the app opens. It leaves the URL in the
/// App Group container and the app collects it.
///
/// The failure worth designing against is not a missing link — it is a link that
/// never goes away. Read it without removing it and every launch imports the same
/// guide again, producing a duplicate in Apple Maps each time, which is precisely
/// the thing this app exists to avoid. So the contract is *take*, not read: the
/// native side deletes the file as it hands it over, and this pins that
/// behaviour on the stub every other test uses.
void main() {
  // A MethodChannel needs the services binding, even from a plain test.
  TestWidgetsFlutterBinding.ensureInitialized();

  test('a shared link is handed over exactly once', () async {
    final inbox = StubShareInbox(
      'https://maps.apple/ug/IgmWnPF.ByS5J5gZk36cDB',
    );
    expect(await inbox.take(), contains('maps.apple/ug/'));
    // Second call: nothing left. An import loop starts here if this ever fails.
    expect(await inbox.take(), isNull);
    expect(await inbox.take(), isNull);
  });

  test('an empty inbox is the normal case, not an error', () async {
    final inbox = StubShareInbox();
    expect(await inbox.take(), isNull);
  });

  test('the channel implementation degrades to nothing waiting', () async {
    // No plugin in a test binding, which is also what a missing App Group looks
    // like on a device. Either way the answer is "no link", never an exception:
    // the paste route still works and a share extension the user has not set up
    // must not break the app they have.
    const inbox = MethodChannelShareInbox();
    expect(await inbox.take(), isNull);
  });
}
