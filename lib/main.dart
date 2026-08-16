import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import 'src/guide_link.dart';
import 'src/ocr.dart';
import 'src/resolver.dart';

void main() => runApp(const ReelPlacesApp());

class ReelPlacesApp extends StatelessWidget {
  const ReelPlacesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF9B2D5E),
      brightness: MediaQuery.platformBrightnessOf(context) == Brightness.dark
          ? Brightness.dark
          : Brightness.light,
    );
    return MaterialApp(
      title: 'Reel Places',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: scheme, useMaterial3: true),
      home: const CapturePage(),
    );
  }
}

/// A place the user has confirmed, waiting to be published.
class Pending {
  final String readAs; // what OCR saw
  final PlaceMatch match; // what it resolved to
  bool keep;
  Pending(this.readAs, this.match, {this.keep = true});
}

class CapturePage extends StatefulWidget {
  const CapturePage({super.key});
  @override
  State<CapturePage> createState() => _CapturePageState();
}

class _CapturePageState extends State<CapturePage> {
  final _picker = ImagePicker();
  final _resolver = StubResolver();
  final _pending = <Pending>[];
  String? _status;
  bool _busy = false;

  Future<void> _importScreenshots() async {
    setState(() {
      _busy = true;
      _status = null;
    });
    try {
      // Multi-select by default: a five-place reel is five screenshots, and
      // importing them one at a time would be tedious in exactly the case this
      // app exists for.
      final files = await _picker.pickMultiImage();
      if (files.isEmpty) {
        setState(() {
          _busy = false;
          _status = 'Nothing selected';
        });
        return;
      }

      var read = 0;
      for (final f in files) {
        final lines = await Ocr.recognise(f.path);
        final guess = likeliestPlace(lines);
        if (guess == null) continue;
        read++;

        final matches = usable(await _resolver.resolve(guess.text));
        if (matches.isEmpty) continue;

        // Never write silently. Apple replaces your label with its own record,
        // so a wrong match ships under a confident name — the confirmation
        // list below is where accuracy actually lives.
        final already = _pending.any((p) => p.match.id == matches.first.id);
        if (!already) {
          _pending.add(Pending(guess.text, matches.first));
        }
      }

      setState(() {
        _busy = false;
        _status = '$read of ${files.length} screenshots yielded a place';
      });
    } on OcrUnavailable catch (e) {
      setState(() {
        _busy = false;
        _status = e.message;
      });
    } catch (e) {
      setState(() {
        _busy = false;
        _status = '$e';
      });
    }
  }

  Future<void> _publish() async {
    final keep = _pending
        .where((p) => p.keep)
        .map((p) => GuidePlace(id: p.match.id, name: p.match.name))
        .toList();
    if (keep.isEmpty) return;

    // One place appends into a guide that already exists; several can only
    // become a new guide, because guides cannot be merged.
    final url = keep.length == 1
        ? buildPlaceLink(keep.single.id)
        : buildGuideLinks('Reel Places', keep).first;

    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      setState(() => _status = 'Could not open Maps');
    }
  }

  @override
  Widget build(BuildContext context) {
    final keeping = _pending.where((p) => p.keep).length;
    return Scaffold(
      appBar: AppBar(title: const Text('Reel Places')),
      body: Column(
        children: [
          if (_status != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Text(
                _status!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          Expanded(
            child: _pending.isEmpty
                ? const _Empty()
                : ListView.builder(
                    itemCount: _pending.length,
                    itemBuilder: (context, i) {
                      final p = _pending[i];
                      return CheckboxListTile(
                        value: p.keep,
                        onChanged: (v) => setState(() => p.keep = v ?? true),
                        title: Text(p.match.name),
                        subtitle: Text(
                          '${p.match.address}\nread as "${p.readAs}"',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        isThreeLine: true,
                      );
                    },
                  ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: FilledButton.tonalIcon(
                      onPressed: _busy ? null : _importScreenshots,
                      icon: const Icon(Icons.photo_library_outlined),
                      label: Text(_busy ? 'Reading…' : 'Add screenshots'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: keeping == 0 ? null : _publish,
                      icon: const Icon(Icons.map_outlined),
                      label: Text(
                        keeping == 1
                            ? 'Add to a guide'
                            : 'Make a guide ($keeping)',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty();
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.photo_camera_back_outlined,
            size: 48,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            'Screenshot the places in a reel, then add them here.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'One place is added to a guide you already have. '
            'Several become a new one — Apple Maps cannot merge guides.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    ),
  );
}
