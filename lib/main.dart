import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import 'src/entitlement.dart';
import 'src/guide_link.dart';
import 'src/ocr.dart';
import 'src/resolver.dart';
import 'src/store_unlock.dart';

void main() => runApp(const WrenApp());

class WrenApp extends StatelessWidget {
  const WrenApp({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF1E4B45),
      brightness: MediaQuery.platformBrightnessOf(context) == Brightness.dark
          ? Brightness.dark
          : Brightness.light,
    );
    return MaterialApp(
      title: 'Wren',
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
  const CapturePage({super.key, this.store, this.initialPending});

  /// Injectable so the paywall can be tested without StoreKit.
  final UnlockStore? store;

  @visibleForTesting
  final List<Pending>? initialPending;

  @override
  State<CapturePage> createState() => _CapturePageState();
}

class _CapturePageState extends State<CapturePage> {
  final _picker = ImagePicker();
  final _resolver = StubResolver();
  late final UnlockStore _store = widget.store ?? StoreUnlockStore();
  late final List<Pending> _pending = [...?widget.initialPending];

  Entitlement _entitlement = const Entitlement.free();
  String? _status;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    // Start from the cached answer so a paying customer is not shown a paywall
    // while the store is still being asked. The store remains the authority.
    StoreUnlockStore.cachedUnlocked().then((unlocked) {
      if (unlocked && mounted) {
        setState(() => _entitlement = const Entitlement.unlocked());
      }
    });
  }

  /// Apple requires a discoverable way to restore a non-consumable purchase, and
  /// a customer on a new phone should not have to walk into the paywall to find
  /// it. Hence a permanent entry in the app bar rather than only in the sheet.
  Future<void> _restoreFromMenu() async {
    setState(() => _status = 'Checking your Apple Account…');
    final ok = await _store.restore();
    if (!mounted) return;
    setState(() {
      if (ok) {
        _entitlement = const Entitlement.unlocked();
        _status = 'Restored. Guides of any size are unlocked.';
      } else {
        _status = 'No previous purchase found on this Apple Account.';
      }
    });
  }

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

  /// Apple takes the guide's name from the payload and never asks, so this is
  /// the only chance to get it right.
  Future<String?> _askGuideName(int count) async {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Name this guide'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'It will appear under this name in Apple Maps, alongside '
              '$count ${count == 1 ? 'place' : 'places'}.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              autofocus: true,
              maxLength: 60,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Guide name',
                hintText: 'Rome, October',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (v) {
                final name = v.trim();
                if (name.isNotEmpty) Navigator.pop(context, name);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final name = controller.text.trim();
              if (name.isNotEmpty) Navigator.pop(context, name);
            },
            child: const Text('Create guide'),
          ),
        ],
      ),
    );
  }

  /// Offers the unlock, and offers a way forward without it. Dead-ending
  /// someone at a paywall when a smaller guide would still work is the wrong
  /// trade — they came here to save places, not to be sold to.
  Future<_UnlockChoice> _offerUnlock(int selected) async {
    final price = await _store.price() ?? unlimitedFallbackPrice;
    // The store round trip can outlive this page.
    if (!mounted) return _UnlockChoice.cancel;
    final over = _entitlement.overBy(selected);
    final choice = await showModalBottomSheet<_UnlockChoice>(
      context: context,
      showDragHandle: true,
      // Scrollable and height-controlled: at large text sizes, or on a short
      // viewport, a fixed sheet overflows and the buttons become unreachable.
      isScrollControlled: true,
      builder: (context) => SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Guides of any size',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              Text(
                'Wren saves up to $freePlaceLimit places in a guide for free. '
                'You have $selected selected, which is $over more.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'One payment, kept for good. No subscription.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pop(context, _UnlockChoice.buy),
                  child: Text('Unlock for $price'),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: FilledButton.tonal(
                  onPressed: () =>
                      Navigator.pop(context, _UnlockChoice.publishFree),
                  child: Text('Save the first $freePlaceLimit instead'),
                ),
              ),
              const SizedBox(height: 4),
              Center(
                child: TextButton(
                  onPressed: () =>
                      Navigator.pop(context, _UnlockChoice.restore),
                  child: const Text('Restore a previous purchase'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return choice ?? _UnlockChoice.cancel;
  }

  Future<void> _publish() async {
    var keep = _pending.where((p) => p.keep).toList();
    if (keep.isEmpty) return;

    switch (_entitlement.check(keep.length)) {
      case PublishBlock.nothingSelected:
        return;
      case PublishBlock.needsUnlock:
        final choice = await _offerUnlock(keep.length);
        switch (choice) {
          case _UnlockChoice.buy:
            if (await _store.buy()) {
              setState(() => _entitlement = const Entitlement.unlocked());
            } else {
              setState(
                () => _status =
                    'The purchase did not complete, so nothing was charged.',
              );
              return;
            }
          case _UnlockChoice.restore:
            if (await _store.restore()) {
              setState(() => _entitlement = const Entitlement.unlocked());
            } else {
              setState(
                () => _status =
                    'No previous purchase found on this Apple Account.',
              );
              return;
            }
          case _UnlockChoice.publishFree:
            keep = keep.take(freePlaceLimit).toList();
          case _UnlockChoice.cancel:
            return;
        }
      case PublishBlock.none:
        break;
    }

    final places = keep
        .map((p) => GuidePlace(id: p.match.id, name: p.match.name))
        .toList();

    // A single place goes to its own card, where "Add to Guide" can append it to
    // a guide that already exists. Several can only become a new guide, because
    // Apple Maps cannot merge them — so that is the only case worth naming.
    final String url;
    if (places.length == 1) {
      url = buildPlaceLink(places.single.id);
    } else {
      final name = await _askGuideName(places.length);
      if (name == null) return;
      url = buildGuideLinks(name, places).first;
    }

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
    final over = _entitlement.overBy(keeping);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wren'),
        actions: [
          if (!_entitlement.unlimited)
            PopupMenuButton<String>(
              onSelected: (v) {
                if (v == 'restore') _restoreFromMenu();
              },
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: 'restore',
                  child: Text('Restore purchase'),
                ),
              ],
            ),
        ],
      ),
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
          if (over > 0)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Text(
                '$over over the free limit of $freePlaceLimit — '
                'you will be asked to unlock, or you can save the first '
                '$freePlaceLimit.',
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

enum _UnlockChoice { buy, restore, publishFree, cancel }

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
            'Screenshot the places people tell you about, then add them here.',
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
