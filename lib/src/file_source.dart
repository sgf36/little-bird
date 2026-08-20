/// Getting an exported file off the device and into text.
///
/// The picker is a channel into `UIDocumentPickerViewController` rather than a
/// plugin dependency, for the same reason OCR and place lookup are: this app
/// adds native code in `AppDelegate.swift` because there is no Xcode here to
/// add files to a target with, and a pod that fails to link fails in CI where
/// it is expensive to diagnose.
///
/// What arrives is bytes, not text, and that is deliberate. A KMZ is a zip; a
/// CSV saved out of Excel is often UTF-16 or Windows-1252 rather than UTF-8.
/// Deciding here — where the bytes are still intact — beats letting a wrong
/// decode reach the parser, where it looks like a malformed file.
library;

import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class FileSourceUnavailable implements Exception {
  final String message;

  /// True when there is no picker at all, rather than a failure inside it, so
  /// the UI can substitute a translated message instead of showing one that
  /// came back from the OS in the OS's own words.
  final bool unsupported;

  FileSourceUnavailable(this.message, {this.unsupported = false});
  @override
  String toString() => 'FileSourceUnavailable: $message';
}

/// A file the user chose, already turned into text.
class PickedFile {
  final String name;
  final String text;
  const PickedFile({required this.name, required this.text});
}

abstract class FileSource {
  /// Shows the document picker. Null when the user backed out, which is not an
  /// error and must not be reported as one.
  Future<PickedFile?> pick();
}

/// The zip local-file-header magic. A KMZ is a zip and a KML is not, and the
/// extension is not reliable enough to tell them apart — users rename things,
/// and some exporters write `.kml` for a zipped file.
const _zipMagic = [0x50, 0x4b, 0x03, 0x04];

/// Turns the bytes of a picked file into text.
///
/// Exposed for tests, because every one of these cases was found in a real
/// export and none of them is reachable through the picker in a test.
String decodeFileBytes(Uint8List bytes, {String? name}) {
  if (bytes.isEmpty) throw FileSourceUnavailable('that file is empty');

  if (bytes.length >= 4 &&
      bytes[0] == _zipMagic[0] &&
      bytes[1] == _zipMagic[1] &&
      bytes[2] == _zipMagic[2] &&
      bytes[3] == _zipMagic[3]) {
    return _kmlFromZip(bytes);
  }

  // UTF-16 with a byte-order mark. Excel writes this when a sheet holds
  // anything outside Latin-1, which a list of Tokyo restaurants certainly
  // does, and decoded as UTF-8 it arrives as text separated by NUL bytes.
  if (bytes.length >= 2) {
    if (bytes[0] == 0xff && bytes[1] == 0xfe) return _utf16(bytes, 2, false);
    if (bytes[0] == 0xfe && bytes[1] == 0xff) return _utf16(bytes, 2, true);
  }

  var body = bytes;
  // A UTF-8 BOM would otherwise become an invisible character glued to the
  // first header name, so `Title` stops matching and the file reads as having
  // no name column at all.
  if (body.length >= 3 &&
      body[0] == 0xef &&
      body[1] == 0xbb &&
      body[2] == 0xbf) {
    body = Uint8List.sublistView(body, 3);
  }

  try {
    return utf8.decode(body);
  } on FormatException {
    // Not UTF-8. Latin-1 always decodes, so this cannot fail again; accented
    // names may come out wrong, but a slightly wrong name still resolves where
    // a refused file imports nothing.
    return latin1.decode(body, allowInvalid: true);
  }
}

String _utf16(Uint8List bytes, int start, bool bigEndian) {
  final units = <int>[];
  for (var i = start; i + 1 < bytes.length; i += 2) {
    units.add(
      bigEndian
          ? (bytes[i] << 8) | bytes[i + 1]
          : (bytes[i + 1] << 8) | bytes[i],
    );
  }
  return String.fromCharCodes(units);
}

String _kmlFromZip(Uint8List bytes) {
  final Archive archive;
  try {
    archive = ZipDecoder().decodeBytes(bytes);
  } catch (e) {
    throw FileSourceUnavailable('that file is a damaged archive');
  }
  // A KMZ holds doc.kml plus images. Prefer doc.kml, then any .kml, and ignore
  // everything else rather than guessing at the largest entry.
  final files = archive.files.where((f) => f.isFile).toList();
  ArchiveFile? pick;
  for (final f in files) {
    final lower = f.name.toLowerCase();
    if (lower.endsWith('doc.kml')) {
      pick = f;
      break;
    }
    if (pick == null && lower.endsWith('.kml')) pick = f;
  }
  if (pick == null) {
    throw FileSourceUnavailable('that archive holds no KML');
  }
  return decodeFileBytes(Uint8List.fromList(pick.content as List<int>));
}

/// The document picker on the device.
class DocumentFileSource implements FileSource {
  static const _channel = MethodChannel('littlebird/files');

  @override
  Future<PickedFile?> pick() async {
    try {
      final m = await _channel.invokeMapMethod<Object?, Object?>('pick');
      if (m == null) return null; // cancelled
      final bytes = m['bytes'] as Uint8List?;
      if (bytes == null) return null;
      final name = (m['name'] as String?) ?? '';
      return PickedFile(
        name: name,
        text: decodeFileBytes(bytes, name: name),
      );
    } on MissingPluginException catch (e) {
      // Printed, not swallowed. The caller turns this into "could not read that
      // file", which reads exactly like a bad file -- so on a device the one
      // thing worth knowing, that no platform answered at all, was invisible.
      debugPrint('littlebird/files has no platform handler: $e');
      throw FileSourceUnavailable(
        'choosing a file needs a platform implementation, and this build has '
        'none',
        unsupported: true,
      );
    } on PlatformException catch (e) {
      throw FileSourceUnavailable(e.message ?? e.code);
    }
  }
}

/// Returns a fixed export, so the import flow can be exercised without a
/// device. Never returns null: cancelling is tested by a source that does.
class StubFileSource implements FileSource {
  StubFileSource(this.text, {this.name = 'places.csv'});
  final String text;
  final String name;

  @override
  Future<PickedFile?> pick() async => PickedFile(name: name, text: text);
}
