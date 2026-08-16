import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import 'l10n/app_localizations.dart';
import 'src/entitlement.dart';
import 'src/guide_link.dart';
import 'src/ocr.dart';
import 'src/place_search_sheet.dart';
import 'src/region_hint.dart';
import 'src/resolver.dart';
import 'src/review_unlock.dart' as review;
import 'src/splash.dart';
import 'src/store_unlock.dart';
import 'src/theme.dart';
import 'src/wren_mark.dart';

void main() => runApp(const WrenApp());

class WrenApp extends StatelessWidget {
  const WrenApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    // Not translated. It is the app's name, and it is a bird.
    title: 'Wren',
    debugShowCheckedModeBanner: false,
    theme: Wren.theme,
    // Both lists come from the generated class, so adding an .arb file is the
    // whole of adding a language — there is no second place to keep in step.
    localizationsDelegates: L.localizationsDelegates,
    supportedLocales: L.supportedLocales,
    home: const SplashGate(child: CapturePage()),
  );
}

/// One thing read off a screenshot, matched or not.
///
/// Unmatched readings are kept rather than dropped. Previously a name the map
/// did not recognise vanished with only a count to show for it, which threw
/// away the one record of what the user had actually seen — and left them no
/// way to fix it.
class Pending {
  /// What OCR read. Never edited: it is the evidence, and the only trace of
  /// what the screenshot said.
  final String readAs;

  /// What it resolved to, or null while it is still unidentified.
  PlaceMatch? match;

  bool keep;

  Pending(this.readAs, this.match, {this.keep = true});

  bool get resolved => match != null;

  /// Only a resolved place can go in a guide — an Apple place id is required.
  bool get publishable => resolved && keep;
}

class CapturePage extends StatefulWidget {
  const CapturePage({
    super.key,
    this.store,
    this.resolver,
    this.initialPending,
  });

  /// Injectable so the paywall and the list can be tested without StoreKit or
  /// MapKit, neither of which exists off-device.
  final UnlockStore? store;
  final PlaceResolver? resolver;

  @visibleForTesting
  final List<Pending>? initialPending;

  @override
  State<CapturePage> createState() => _CapturePageState();
}

class _CapturePageState extends State<CapturePage> {
  final _picker = ImagePicker();
  late final PlaceResolver _resolver = widget.resolver ?? MapKitResolver();
  late final UnlockStore _store = widget.store ?? StoreUnlockStore();
  late final List<Pending> _pending = [...?widget.initialPending];

  Entitlement _entitlement = const Entitlement.free();
  String? _status;
  bool _busy = false;
  int _readCount = 0;
  int _totalCount = 0;
  Region? _region;

  @override
  void initState() {
    super.initState();
    StoreUnlockStore.cachedUnlocked().then((unlocked) {
      if (unlocked && mounted) {
        setState(() => _entitlement = const Entitlement.unlocked());
      }
    });
    review.wasUnlocked().then((unlocked) {
      if (unlocked && mounted) {
        setState(() => _entitlement = const Entitlement.unlocked());
      }
    });
  }

  /// Reached by long-pressing the title. Nothing on screen advertises it, and
  /// builds without a review code compiled in do not have it at all.
  Future<void> _reviewUnlock() async {
    if (!review.available || _entitlement.unlimited) return;
    final l = L.of(context);
    final controller = TextEditingController();
    final entered = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          l.reviewerAccess,
          style: const TextStyle(fontFamily: Wren.serif),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          autocorrect: false,
          enableSuggestions: false,
          decoration: InputDecoration(labelText: l.code),
          onSubmitted: (v) => Navigator.pop(context, v),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l.cancel, style: const TextStyle(color: Wren.muted)),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text),
            style: FilledButton.styleFrom(minimumSize: const Size(0, 44)),
            child: Text(l.unlock),
          ),
        ],
      ),
    );
    if (entered == null || !mounted) return;

    if (review.matches(entered)) {
      await review.remember();
      if (!mounted) return;
      setState(() {
        _entitlement = const Entitlement.unlocked();
        _status = l.reviewerEnabled;
      });
    } else {
      setState(() => _status = l.codeNotRecognised);
    }
  }

  Future<void> _restoreFromMenu() async {
    final l = L.of(context);
    setState(() => _status = l.checkingAppleAccount);
    final ok = await _store.restore();
    if (!mounted) return;
    setState(() {
      if (ok) {
        _entitlement = const Entitlement.unlocked();
        _status = l.restoredUnlocked;
      } else {
        _status = l.noPreviousPurchase;
      }
    });
  }

  /// Asks where the batch is, with whatever the captions suggested filled in.
  ///
  /// Confirming beats guessing here. A wrong region is the expensive failure —
  /// it drags every lookup toward the wrong city and each result comes back
  /// looking perfectly valid — and the caption is not always there to read.
  Future<Region?> _confirmRegion(String? detected) async {
    final l = L.of(context);
    final controller = TextEditingController(text: detected ?? '');
    final answer = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          l.whereAreThesePlaces,
          style: const TextStyle(fontFamily: Wren.serif),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              detected == null ? l.regionNotDetected : l.regionDetected,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                labelText: l.cityOrRegion,
                hintText: l.cityExample,
              ),
              onSubmitted: (v) => Navigator.pop(context, v.trim()),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, ''),
            child: Text(
              l.searchAnywhere,
              style: const TextStyle(color: Wren.muted),
            ),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            style: FilledButton.styleFrom(minimumSize: const Size(0, 44)),
            child: Text(l.findPlaces),
          ),
        ],
      ),
    );

    if (answer == null || answer.isEmpty) return null;
    return _resolver.locate(answer);
  }

  Future<void> _importScreenshots() async {
    final l = L.of(context);
    setState(() {
      _busy = true;
      _status = null;
    });
    try {
      final files = await _picker.pickMultiImage();
      if (files.isEmpty) {
        setState(() {
          _busy = false;
          _status = null;
        });
        return;
      }

      setState(() {
        _totalCount = files.length;
        _readCount = 0;
      });

      // Pass one: read everything, and keep the whole page of text. The caption
      // is the part that says where we are, and it used to be discarded.
      final readings = <({String place, String all})>[];
      var unread = 0;
      for (final f in files) {
        final lines = await Ocr.recognise(f.path);
        if (mounted) setState(() => _readCount++);
        final guess = likeliestPlace(lines);
        if (guess == null) {
          unread++;
          continue;
        }
        readings.add((
          place: guess.text,
          all: lines.map((l) => l.text).join('\n'),
        ));
      }

      if (readings.isEmpty) {
        setState(() {
          _busy = false;
          _status = l.nothingReadable(files.length);
        });
        return;
      }

      // Pass two: work out where, and have it confirmed.
      final detected = regionHint(
        readings.map((r) => r.all),
        exclude: readings.map((r) => r.place),
      );
      setState(() => _busy = false);
      if (!mounted) return;
      final region = await _confirmRegion(detected);
      if (!mounted) return;
      setState(() {
        _busy = true;
        _region = region;
      });

      // Pass three: resolve, now that the search knows where to look.
      var unmatched = 0, added = 0;
      for (final r in readings) {
        List<PlaceMatch> matches;
        try {
          matches = usable(await _resolver.resolve(r.place, region: region));
        } on ResolverUnavailable catch (e) {
          setState(() {
            _busy = false;
            _status = e.throttled
                ? l.rateLimitedDuringImport(added)
                : e.unsupported
                ? l.lookupUnavailable
                : e.message;
          });
          return;
        }
        if (matches.isEmpty) {
          // Kept, not discarded: the reading is the only record of what the
          // screenshot said, and the user can search for it themselves.
          unmatched++;
          _pending.add(Pending(r.place, null, keep: false));
          continue;
        }
        // Never write silently: Apple replaces the label with its own record,
        // so a wrong match would ship under a confident name.
        if (!_pending.any((p) => p.match?.id == matches.first.id)) {
          _pending.add(Pending(r.place, matches.first));
          added++;
        }
      }

      setState(() {
        _busy = false;
        _status = [
          l.importSummary(added),
          if (region != null) l.importSummaryIn(region.name),
          if (unmatched > 0) '· ${l.importSummaryNeedLook(unmatched)}',
          if (unread > 0) '· ${l.importSummaryUnreadable(unread)}',
        ].join(' ');
      });
    } on OcrUnavailable catch (e) {
      setState(() {
        _busy = false;
        _status = e.unsupported ? l.ocrUnavailable : e.message;
      });
    } catch (e) {
      setState(() {
        _busy = false;
        _status = '$e';
      });
    }
  }

  Future<String?> _askGuideName(int count) async {
    final l = L.of(context);
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          l.nameThisGuide,
          style: const TextStyle(fontFamily: Wren.serif),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l.nameThisGuideBody(count),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              autofocus: true,
              maxLength: 60,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                labelText: l.guideName,
                hintText: l.guideNameExample,
              ),
              onSubmitted: (v) {
                if (v.trim().isNotEmpty) Navigator.pop(context, v.trim());
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l.cancel, style: const TextStyle(color: Wren.muted)),
          ),
          FilledButton(
            onPressed: () {
              final name = controller.text.trim();
              if (name.isNotEmpty) Navigator.pop(context, name);
            },
            style: FilledButton.styleFrom(minimumSize: const Size(0, 44)),
            child: Text(l.createGuide),
          ),
        ],
      ),
    );
  }

  Future<_UnlockChoice> _offerUnlock(int selected) async {
    final l = L.of(context);
    final price = await _store.price() ?? unlimitedFallbackPrice;
    if (!mounted) return _UnlockChoice.cancel;
    final over = _entitlement.overBy(selected);
    final choice = await showModalBottomSheet<_UnlockChoice>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 4, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WrenMark(size: 44),
              const SizedBox(height: 16),
              Text(
                l.guidesOfAnySize,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 10),
              Text(
                l.unlockExplain(freePlaceLimit, selected, over),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 6),
              Text(
                l.onePaymentKept,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 22),
              FilledButton(
                onPressed: () => Navigator.pop(context, _UnlockChoice.buy),
                // The price string comes from StoreKit already formatted for
                // the storefront, so it is never reformatted here.
                child: Text(l.unlockFor(price)),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () =>
                    Navigator.pop(context, _UnlockChoice.publishFree),
                child: Text(l.saveFirstInstead(freePlaceLimit)),
              ),
              const SizedBox(height: 2),
              Center(
                child: TextButton(
                  onPressed: () =>
                      Navigator.pop(context, _UnlockChoice.restore),
                  child: Text(
                    l.restorePrevious,
                    style: const TextStyle(color: Wren.muted),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return choice ?? _UnlockChoice.cancel;
  }

  /// Opens the lookup for a row — to correct a wrong match, or to find one that
  /// was never made.
  Future<void> _editPlace(int index) async {
    final l = L.of(context);
    final p = _pending[index];
    final chosen = await showModalBottomSheet<PlaceMatch>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => PlaceSearchSheet(
        readAs: p.readAs,
        resolver: _resolver,
        region: _region,
        initialQuery: p.match?.name ?? p.readAs,
      ),
    );
    if (chosen == null || !mounted) return;

    final duplicate = _pending.indexWhere(
      (o) => o != p && o.match?.id == chosen.id,
    );
    setState(() {
      p.match = chosen;
      p.keep = true;
      if (duplicate >= 0) {
        _status = l.alreadyInTheList(chosen.name);
      }
    });
  }

  Future<void> _publish() async {
    final l = L.of(context);
    var keep = _pending.where((p) => p.publishable).toList();
    if (keep.isEmpty) return;

    switch (_entitlement.check(keep.length)) {
      case PublishBlock.nothingSelected:
        return;
      case PublishBlock.needsUnlock:
        switch (await _offerUnlock(keep.length)) {
          case _UnlockChoice.buy:
            if (await _store.buy()) {
              setState(() => _entitlement = const Entitlement.unlocked());
            } else {
              setState(() => _status = l.purchaseDidNotComplete);
              return;
            }
          case _UnlockChoice.restore:
            if (await _store.restore()) {
              setState(() => _entitlement = const Entitlement.unlocked());
            } else {
              setState(() => _status = l.noPreviousPurchase);
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

    // Safe to force: `publishable` already required a match.
    final places = keep
        .map((p) => GuidePlace(id: p.match!.id, name: p.match!.name))
        .toList();

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
      setState(() => _status = l.couldNotOpenMaps);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = L.of(context);
    final keeping = _pending.where((p) => p.publishable).length;
    final unresolved = _pending.where((p) => !p.resolved).length;
    final over = _entitlement.overBy(keeping);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
        title: GestureDetector(
          // Long press opens reviewer access. Undiscoverable on purpose, and
          // absent entirely from builds with no review code compiled in.
          onLongPress: _reviewUnlock,
          child: Row(
            children: [
              const WrenMark(size: 30),
              const SizedBox(width: 10),
              Text(
                'Wren',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontSize: 21),
              ),
            ],
          ),
        ),
        actions: [
          if (!_entitlement.unlimited)
            PopupMenuButton<String>(
              onSelected: (v) {
                if (v == 'restore') _restoreFromMenu();
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'restore',
                  child: Text(l.restorePurchase),
                ),
              ],
            ),
          const SizedBox(width: 4),
        ],
      ),
      body: Column(
        children: [
          if (_busy && _totalCount > 0)
            _Banner(
              accent: Wren.gold,
              child: Text(
                l.readingProgress(_readCount, _totalCount),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          if (!_busy && _status != null)
            _Banner(
              accent: Wren.line,
              child: Text(
                _status!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          if (_region != null && _pending.isNotEmpty)
            _Banner(
              accent: Wren.gold,
              child: Row(
                children: [
                  const Icon(Icons.place_outlined, size: 15, color: Wren.muted),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      l.searchedIn(_region!.label),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          if (unresolved > 0)
            _Banner(
              accent: Wren.clay,
              child: Text(
                l.notFoundBanner(unresolved),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          if (over > 0)
            _Banner(
              accent: Wren.clay,
              child: Text(
                l.overFreeLimit(over, freePlaceLimit),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          Expanded(
            child: _pending.isEmpty
                ? const _Empty()
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    itemCount: _pending.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 10),
                    itemBuilder: (context, i) => _PlaceCard(
                      pending: _pending[i],
                      onChanged: (v) =>
                          setState(() => _pending[i].keep = v ?? true),
                      onEdit: () => _editPlace(i),
                    ),
                  ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _busy ? null : _importScreenshots,
                      icon: const Icon(
                        Icons.add_photo_alternate_outlined,
                        size: 20,
                      ),
                      label: Text(
                        _busy ? l.readingShort : l.addScreenshots,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: keeping == 0 ? null : _publish,
                      icon: const Icon(Icons.map_outlined, size: 20),
                      label: Text(
                        keeping == 1 ? l.addToGuide : l.makeGuide(keeping),
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

class _Banner extends StatelessWidget {
  const _Banner({required this.child, required this.accent});
  final Widget child;
  final Color accent;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    margin: const EdgeInsets.fromLTRB(16, 4, 16, 4),
    padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
    decoration: BoxDecoration(
      color: Wren.raised,
      border: Border(left: BorderSide(color: accent, width: 3)),
      borderRadius: const BorderRadius.horizontal(right: Radius.circular(8)),
    ),
    child: child,
  );
}

class _PlaceCard extends StatelessWidget {
  const _PlaceCard({
    required this.pending,
    required this.onChanged,
    required this.onEdit,
  });

  final Pending pending;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final l = L.of(context);
    final t = Theme.of(context).textTheme;
    final match = pending.match;
    final resolved = match != null;

    return Opacity(
      opacity: resolved && !pending.keep ? 0.5 : 1,
      child: Material(
        color: Wren.raised,
        // Shape only — Material asserts if both shape and borderRadius are
        // given, which crashed the whole list the moment an unmatched place
        // appeared in it.
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: resolved
              ? BorderSide.none
              : const BorderSide(color: Wren.clay, width: 1.2),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          // Tapping anywhere opens the lookup. Correcting a wrong match and
          // finding one that failed are the same job, so they are one gesture.
          onTap: onEdit,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 8, 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (resolved) ...[
                        Text(match.name, style: t.titleMedium),
                        const SizedBox(height: 3),
                        Text(match.address, style: t.bodySmall),
                      ] else ...[
                        Row(
                          children: [
                            const Icon(
                              Icons.help_outline,
                              size: 16,
                              color: Wren.clay,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                l.notFoundOnMap,
                                style: t.titleMedium?.copyWith(
                                  fontSize: 16,
                                  color: Wren.clay,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(l.tapToSearchForIt, style: t.bodySmall),
                      ],
                      // Always shown, matched or not. It is what the screenshot
                      // said, and the only way to tell a right match from a
                      // confident wrong one.
                      const SizedBox(height: 7),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.text_fields,
                            size: 13,
                            color: Wren.muted,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              l.readAs(pending.readAs),
                              style: t.bodySmall?.copyWith(fontSize: 12.5),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (resolved)
                  Checkbox(value: pending.keep, onChanged: onChanged)
                else
                  IconButton(
                    icon: const Icon(Icons.search, color: Wren.clay),
                    tooltip: l.searchAppleMaps,
                    onPressed: onEdit,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty();

  @override
  Widget build(BuildContext context) {
    final l = L.of(context);
    final t = Theme.of(context).textTheme;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(36, 0, 36, 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const WrenMark(size: 92),
            const SizedBox(height: 26),
            Text(
              l.emptyTitle,
              style: t.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              l.emptyBody,
              style: t.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),
            Text(
              l.emptyNote,
              style: t.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
