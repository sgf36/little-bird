import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import 'l10n/app_localizations.dart';
import 'src/entitlement.dart';
import 'src/file_source.dart';
import 'src/guide_expand.dart';
import 'src/guide_import.dart';
import 'src/guide_link.dart';
import 'src/ocr.dart';
import 'src/place_files.dart';
import 'src/map_targets.dart';
import 'src/place_export.dart';
import 'src/place_search_sheet.dart';
import 'src/place_share.dart';
import 'src/region_hint.dart';
import 'src/resolver.dart';
import 'src/share_inbox.dart';
import 'src/comp_unlock.dart' as comp;
import 'src/screenshots.dart';
import 'src/splash.dart';
import 'src/store_unlock.dart';
import 'src/theme.dart';
import 'src/wren_mark.dart';

/// True only in the build made for taking store screenshots.
///
/// A compile-time constant, so the normal build contains none of the scene
/// fixtures — tree shaking removes them — and a shipped app cannot be talked
/// into showing a fake list of places by any runtime input.
const _shots = bool.fromEnvironment('WREN_SHOTS');

void main() {
  if (_shots) {
    // Named per launch, so one build covers every scene and every language. Two
    // routes are tried — see [SceneRequest] — because the environment variable
    // alone arrived empty on iOS 26 and cost a whole run.
    final request = SceneRequest.resolve();
    // Read back off the device log by shoot.py after every launch, so the log
    // says which route delivered the scene even on a run that succeeds.
    debugPrint(request.logLine);
    runApp(WrenApp(home: sceneFor(request.name) ?? UnknownScene.from(request)));
    return;
  }
  runApp(const WrenApp());
}

class WrenApp extends StatelessWidget {
  const WrenApp({super.key, this.home});

  /// Replaced only by the screenshot build. Normally the splash gate.
  final Widget? home;

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
    // No splash in the screenshot build: it animates, and a screenshot taken
    // during it catches the mark half-faded.
    home: home ?? const SplashGate(child: CapturePage()),
  );
}

/// Where a place in the list came from.
///
/// Worth distinguishing because it changes three things: whether the row shows
/// what was read (a place taken from Apple's own guide has no reading to
/// second-guess), whether it counts against the free limit, and whether it can
/// be truncated when someone publishes free — places the user already had must
/// never be dropped to fit a cap.
enum Origin { screenshot, file, guide }

/// One thing on the list, matched or not.
///
/// Unmatched readings are kept rather than dropped. Previously a name the map
/// did not recognise vanished with only a count to show for it, which threw
/// away the one record of what the user had actually seen — and left them no
/// way to fix it.
class Pending {
  /// What OCR read, or what the imported file called it. Never edited: it is
  /// the evidence, and the only trace of what the source said.
  final String readAs;

  /// What it resolved to, or null while it is still unidentified.
  PlaceMatch? match;

  /// What the file itself said, when the file supplied a coordinate.
  ///
  /// A file import is the one source that arrives already positioned: a KML or
  /// GPX carries the coordinate, so there is nothing to look up. That matters
  /// because looking up is the part that needs Apple's map — and on Android
  /// there is no Apple map, which used to make an import of a perfectly good
  /// file end in "Place lookup needs an iPhone" and an empty list.
  ///
  /// Such a place can be written into a file for another app. It cannot go into
  /// an Apple Maps guide, which identifies places by Apple's own id and nothing
  /// else.
  final ExportPlace? fromFile;

  bool keep;

  final Origin origin;

  Pending(
    this.readAs,
    this.match, {
    this.keep = true,
    this.origin = Origin.screenshot,
    this.fromFile,
  });

  bool get resolved => match != null;

  /// Only a resolved place can go in a guide — an Apple place id is required.
  bool get publishable => resolved && keep;

  /// Whether this place can be written into a file another map app will read.
  ///
  /// Wider than [publishable] on purpose. An OpenStreetMap app wants a
  /// coordinate and does not care whether Apple has ever heard of the place; a
  /// guide wants Apple's identifier and does not care about the coordinate.
  bool get exportable =>
      keep &&
      ((match?.hasCoordinate ?? false) || (fromFile?.hasCoordinate ?? false));

  /// The place as a file should carry it, or null when it cannot be written.
  ExportPlace? get forExport =>
      ExportPlace.from(match, readAs: readAs) ?? fromFile;

  /// Whether this place is one the user is being charged for. A place carried
  /// over from a guide they already own is not.
  bool get billable => origin != Origin.guide;
}

class CapturePage extends StatefulWidget {
  const CapturePage({
    super.key,
    this.store,
    this.resolver,
    this.files,
    this.expander,
    this.shareInbox,
    this.sharer,
    this.initialPending,
    this.initialGuideName,
    this.initialOverlay = ScreenshotOverlay.none,
  });

  /// Injectable so the paywall, the list and the importers can be tested
  /// without StoreKit, MapKit or a document picker, none of which exists
  /// off-device.
  final UnlockStore? store;
  final PlaceResolver? resolver;
  final FileSource? files;
  final LinkExpander? expander;

  /// Injectable so the share-sheet handoff can be tested without an extension.
  final ShareInbox? shareInbox;

  /// Injectable so sending to another map app can be tested without a device.
  final PlaceSharer? sharer;

  @visibleForTesting
  final List<Pending>? initialPending;

  /// The guide imported places came from, when the list starts with some.
  @visibleForTesting
  final String? initialGuideName;

  /// Opens one of the app's own overlays as soon as the first frame is up.
  ///
  /// Only for the store-screenshot build. It calls the same methods a tap
  /// calls, deliberately: a screenshot harness that rebuilt these dialogs to
  /// look right would keep looking right after the real ones changed.
  final ScreenshotOverlay initialOverlay;

  @override
  State<CapturePage> createState() => _CapturePageState();
}

class _CapturePageState extends State<CapturePage> with WidgetsBindingObserver {
  final _picker = ImagePicker();
  late final PlaceResolver _resolver = widget.resolver ?? MapKitResolver();
  late final UnlockStore _store = widget.store ?? StoreUnlockStore();
  late final FileSource _files = widget.files ?? DocumentFileSource();
  late final LinkExpander _expander = widget.expander ?? HttpLinkExpander();
  late final ShareInbox _shareInbox =
      widget.shareInbox ?? const MethodChannelShareInbox();
  late final PlaceSharer _sharer =
      widget.sharer ?? const MethodChannelPlaceSharer();

  /// The My Map the user chose to keep adding to, if they have picked one.
  ///
  /// Remembering it is worth two taps every time: with an id the Custom Tab can
  /// open that map's edit page directly instead of the list plus a create step.
  String? _myMapId;
  late final List<Pending> _pending = [...?widget.initialPending];

  /// Guide links still to be handed to Apple Maps.
  ///
  /// Maps takes one link at a time, so a list that needs splitting is opened
  /// across several trips. Held here rather than rebuilt each time, so the
  /// numbering in the guide names cannot drift if the list changes in between.
  final List<String> _queued = [];

  /// How many links the current batch started with, so progress can be counted
  /// forwards rather than reported as a shrinking remainder.
  int _queuedTotal = 0;

  Entitlement _entitlement = const Entitlement.free();
  String? _status;
  bool _busy = false;
  int _readCount = 0;
  int _totalCount = 0;
  Region? _region;

  /// The guide the carried-over places came from, if any. Kept so the combined
  /// guide can be offered the same name.
  late String? _guideName = widget.initialGuideName;

  /// Entries in the pasted guide that carried no usable identifier. Kept so the
  /// summary can be recomposed if the lookup later proves some places gone.
  int _carriedUnusable = 0;

  /// Whether the carried-over places are showing. Collapsed by default: they
  /// are context, and a guide of forty would bury the two places just added.
  bool _showCarried = false;

  /// Distinguishes the two things that report progress the same way — reading
  /// screenshots and matching names against the map.
  bool _lookingUp = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // A link may be waiting from before the app was even running.
    WidgetsBinding.instance.addPostFrameCallback((_) => _takeSharedGuide());
    StoreUnlockStore.cachedUnlocked().then((unlocked) {
      if (unlocked && mounted) {
        setState(() => _entitlement = const Entitlement.unlocked());
      }
    });
    comp.wasUnlocked().then((unlocked) {
      if (unlocked && mounted) {
        setState(() => _entitlement = const Entitlement.unlocked());
      }
    });

    if (widget.initialOverlay != ScreenshotOverlay.none) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        switch (widget.initialOverlay) {
          case ScreenshotOverlay.none:
            break;
          case ScreenshotOverlay.region:
            _confirmRegion('Borough Market, London');
          case ScreenshotOverlay.paywall:
            _offerUnlock(_pending.where((p) => p.publishable).length);
          case ScreenshotOverlay.search:
            if (_pending.isNotEmpty) _editPlace(0);
          case ScreenshotOverlay.addMenu:
            _addPlaces();
        }
      });
    }
  }

  /// Reached by long-pressing the title. Nothing on screen advertises it, and
  /// a code has to be issued before it does anything — the entry point on its
  /// own is not a way in.
  Future<void> _compUnlock() async {
    if (_entitlement.unlimited) return;
    final l = L.of(context);
    final controller = TextEditingController();
    final entered = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          l.compAccess,
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
    if (entered == null || entered.trim().isEmpty || !mounted) return;

    // Redeeming reaches the network, which the rest of the app never does, so
    // it says so rather than appearing to hang.
    setState(() => _status = l.compChecking);
    final outcome = await comp.redeem(entered);
    if (!mounted) return;

    setState(() {
      switch (outcome) {
        case comp.RedeemOutcome.unlocked:
          _entitlement = const Entitlement.unlocked();
          _status = l.compEnabled;
        case comp.RedeemOutcome.refused:
          _status = l.compRefused;
        case comp.RedeemOutcome.toooften:
          _status = l.compTooOften;
        case comp.RedeemOutcome.unreachable:
          _status = l.compUnreachable;
        case comp.RedeemOutcome.untrusted:
          _status = l.compUntrusted;
      }
    });
  }

  /// Empties the list, after asking.
  ///
  /// The confirmation says what is *not* affected as well as what is. "Clear"
  /// beside a list of places the user has just published reads as though it
  /// might reach into Apple Maps and delete the guide, and it does not.
  Future<void> _clearList() async {
    if (_pending.isEmpty) return;
    final l = L.of(context);
    final go = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          l.clearListTitle,
          style: const TextStyle(fontFamily: Wren.serif),
        ),
        content: Text(
          l.clearListBody(_pending.length),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l.cancel, style: const TextStyle(color: Wren.muted)),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              minimumSize: const Size(0, 44),
              backgroundColor: Wren.clay,
            ),
            child: Text(l.clearListConfirm),
          ),
        ],
      ),
    );
    if (go != true || !mounted) return;
    setState(() {
      _pending.clear();
      // Everything derived from the list goes with it. A guide name left over
      // from a cleared import would silently name the next, unrelated guide.
      _guideName = null;
      _region = null;
      _showCarried = false;
      _queued.clear();
      _status = l.listCleared;
    });
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
      final readings = <({List<String> candidates, String all})>[];
      var unread = 0;
      // Every screenshot is read before any is ranked, because the strongest
      // signal for interface furniture is that it repeats across the batch while
      // places do not. That works in any language and in any app, which a list
      // of English button labels cannot.
      final perShot = <List<TextLine>>[];
      for (final f in files) {
        perShot.add(await Ocr.recognise(f.path));
        if (mounted) setState(() => _readCount++);
      }
      final furniture = repeatedLines(perShot);

      for (final lines in perShot) {
        // Ranked, not a single guess. A tester's TikTok screenshot put the
        // caption in the largest text and the real place in a small truncated
        // label, so a miss on the front runner now falls through to the next
        // candidate instead of costing the screenshot entirely.
        final ranked = placeCandidates(lines, repeated: furniture);
        if (ranked.isEmpty) {
          unread++;
          continue;
        }
        readings.add((
          candidates: [for (final c in ranked.take(3)) c.text.trim()],
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
        exclude: readings.map((r) => r.candidates.first),
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
        List<PlaceMatch> matches = const [];
        var readAs = r.candidates.first;
        try {
          // Each candidate in turn until one is found. The resolver paces
          // itself, so this costs time rather than risking a throttle.
          for (final candidate in r.candidates) {
            matches = usable(
              await _resolver.resolve(candidate, region: region),
            );
            if (matches.isNotEmpty) {
              readAs = candidate;
              break;
            }
          }
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
          _pending.add(Pending(r.candidates.first, null, keep: false));
          continue;
        }
        // Never write silently: Apple replaces the label with its own record,
        // so a wrong match would ship under a confident name.
        if (!_pending.any((p) => p.match?.id == matches.first.id)) {
          _pending.add(Pending(readAs, matches.first));
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

  /// Reads the places out of a guide the user already has, so new ones can be
  /// added to them.
  ///
  /// Only reads. Publishing later makes a *new* guide holding both sets, because
  /// Apple offers no way to add to an existing one from outside Maps — a
  /// limitation the user is told about at the point it matters, in [_publish],
  /// rather than discovered afterwards.
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Sharing a guide out of Apple Maps brings the app forward rather than
  /// starting it, so resuming is when a link usually arrives.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _takeSharedGuide();
  }

  /// Collects a link the share extension left, and imports it.
  ///
  /// Guarded against running twice over the same link: the native side deletes
  /// the file as it hands it over, and [_busy] keeps a resume that lands mid
  /// import from starting a second one.
  Future<void> _takeSharedGuide() async {
    if (_busy) return;
    final link = await _shareInbox.take();
    if (link == null || link.isEmpty || !mounted) return;
    await _importGuide(shared: link);
  }

  /// [shared] arrives from the iOS share sheet, where the user has already
  /// chosen the guide — so the paste dialog is skipped rather than asking them to
  /// hand over something they just handed over.
  Future<void> _importGuide({String? shared}) async {
    final l = L.of(context);
    final controller = TextEditingController();
    final pasted =
        shared ??
        await showDialog<String>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              l.importGuideTitle,
              style: const TextStyle(fontFamily: Wren.serif),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.importGuideBody,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: controller,
                  autofocus: true,
                  autocorrect: false,
                  enableSuggestions: false,
                  maxLines: 2,
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(labelText: l.guideLinkLabel),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  l.cancel,
                  style: const TextStyle(color: Wren.muted),
                ),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(context, controller.text),
                style: FilledButton.styleFrom(minimumSize: const Size(0, 44)),
                child: Text(l.readGuide),
              ),
            ],
          ),
        );
    if (pasted == null || pasted.trim().isEmpty || !mounted) return;

    // Apple's share sheet gives a short link with an opaque id and no payload,
    // so it has to be expanded before there is anything to read. Told plainly
    // that this is happening, because it reaches the network and is the one
    // slow step in an otherwise instant flow.
    var link = pasted.trim();
    if (isShortGuideLink(link)) {
      setState(() => _status = l.expandingLink);
      try {
        link = await _expander.expand(link);
      } on LinkExpandFailed catch (e) {
        if (!mounted) return;
        setState(
          () => _status = e.offline ? l.linkUnreachable : l.importGuideNotALink,
        );
        return;
      }
      if (!mounted) return;
    }

    final ImportedGuide guide;
    try {
      guide = importGuideLink(link);
    } on GuideLinkFormat {
      // Deliberately not the parser's own message. It says things like "field
      // runs past the end", which is the right thing to have in a log and the
      // wrong thing to put in front of someone who pasted the wrong text.
      setState(() => _status = l.importGuideNotALink);
      return;
    }

    if (guide.places.isEmpty) {
      setState(() => _status = l.importGuideNothing);
      return;
    }

    setState(() {
      var added = 0;
      for (final p in guide.places) {
        if (_pending.any((o) => o.match?.id == p.id)) continue;
        _pending.add(
          Pending(
            p.name,
            // Apple's own name and id, straight out of the guide. There is no
            // address in the payload; the row shows the name alone rather than
            // an empty line where one should be.
            PlaceMatch(id: p.id, name: p.name, address: ''),
            origin: Origin.guide,
          ),
        );
        added++;
      }
      if (guide.name.isNotEmpty) _guideName = guide.name;
      _carriedUnusable = guide.unusable;
      _status = [
        l.importedGuideSummary(added),
        if (guide.unusable > 0) '· ${l.importedGuideUnusable(guide.unusable)}',
      ].join(' ');
    });

    await _nameCarriedPlaces();
  }

  /// Fills in the names of imported places, which the payload does not carry.
  ///
  /// Deliberately after the import has already been reported. The places are
  /// usable without names — the identifier is all a guide link needs — so the
  /// count appears immediately and the labels arrive when they arrive. Making
  /// the user wait on a lookup for something cosmetic would be the wrong trade.
  Future<void> _nameCarriedPlaces() async {
    final nameless = _pending
        .where((p) => p.origin == Origin.guide && (p.match?.name ?? '').isEmpty)
        .toList();
    if (nameless.isEmpty) return;

    final result = await _resolver.lookup([
      for (final p in nameless) p.match!.id,
    ]);
    if (result.isEmpty || !mounted) return;
    final l = L.of(context);

    // Only `gone` is evidence. Apple answered about these and has no record, so
    // they cannot appear in any guide made from this list — Apple drops them on
    // arrival, silently, which is why an 82-place guide came back as 80 with
    // nothing to explain the difference. Dropping them here makes the count the
    // user is shown the count they actually get.
    //
    // `failed` is never pruned. Those requests did not complete, which says
    // nothing about whether the place exists, and treating a network hiccup as
    // proof of death would delete places that are perfectly alive.
    final gone = nameless.where((p) => result.gone.contains(p.match!.id));

    setState(() {
      for (final p in nameless) {
        final match = result.found[p.match!.id];
        if (match != null) p.match = match;
      }
      if (gone.isNotEmpty) {
        final dropped = gone.length;
        // Logged by identifier, because that is the only thing left of them.
        // Apple has no record, so there is no name to show and nothing to look
        // up: a dropped place is a bare muid or it is nothing. Printed rather
        // than shown, since the alternative is putting raw hex in front of
        // someone who wanted a list of restaurants.
        debugPrint(
          'WREN-GONE ${result.gone.length} place(s) Apple no longer serves: '
          '${result.gone.map((id) => id.toString()).join(', ')}',
        );
        _pending.removeWhere((p) => result.gone.contains(p.match?.id));
        final carried = _pending.where((p) => p.origin == Origin.guide).length;
        _status = [
          l.importedGuideSummary(carried),
          '· ${l.importedGuideUnusable(_carriedUnusable + dropped)}',
        ].join(' ');
      }
    });
  }

  /// Imports a list exported from another app.
  ///
  /// The file gives names and, usually, coordinates — never Apple place ids, so
  /// every row still goes through the same map lookup an OCR reading does. The
  /// coordinate is worth having anyway: it aims each search individually, which
  /// is better than the one region a batch of screenshots shares, and it is why
  /// a file of places spread across three cities imports correctly.
  Future<void> _importFile() async {
    final l = L.of(context);
    setState(() {
      _busy = true;
      _status = null;
    });

    final PlaceFileResult read;
    try {
      final picked = await _files.pick();
      if (picked == null || !mounted) {
        setState(() => _busy = false);
        return;
      }
      read = readPlaceFile(picked.text, filename: picked.name);
    } on PlaceFileFormat {
      // Same reasoning as the guide link: the parser's complaint is precise and
      // useless here. What helps is knowing which formats work.
      setState(() {
        _busy = false;
        _status = l.fileUnreadable;
      });
      return;
    } on FileSourceUnavailable catch (e) {
      setState(() {
        _busy = false;
        _status = e.unsupported ? l.fileUnreadable : e.message;
      });
      return;
    } catch (e) {
      setState(() {
        _busy = false;
        _status = '$e';
      });
      return;
    }

    if (read.places.isEmpty) {
      setState(() {
        _busy = false;
        _status = l.fileNoPlaces;
      });
      return;
    }

    setState(() {
      _lookingUp = true;
      _totalCount = read.places.length;
      _readCount = 0;
      // The parser has always returned this — a GeoJSON collection name, a KML
      // document name — and this method quietly dropped it, so importing
      // 8-places.geojson offered no guide name at all. Only taken when there is
      // not already one from an imported guide, which is the stronger claim.
      final title = read.title;
      if (_guideName == null && title != null && title.isNotEmpty) {
        _guideName = title;
      }
    });

    var unmatched = 0, added = 0, positioned = 0;
    for (final place in read.places) {
      // What the file said, kept whether or not the map can be asked. This is
      // the fallback that makes an import useful with no lookup at all.
      final own = ExportPlace(
        name: place.name,
        address: place.address ?? '',
        lat: place.lat,
        lon: place.lon,
      );

      List<PlaceMatch> matches;
      try {
        matches = usable(
          await _resolver.resolve(place.query, region: _regionFor(place)),
        );
      } on ResolverUnavailable catch (e) {
        // No map to ask. A file that carried coordinates does not need one, so
        // take the rest of it at its word rather than abandoning the import —
        // which is what used to happen on every platform without MapKit.
        if (e.unsupported) {
          for (final rest in read.places.skip(positioned + unmatched + added)) {
            final own = ExportPlace(
              name: rest.name,
              address: rest.address ?? '',
              lat: rest.lat,
              lon: rest.lon,
            );
            if (!own.hasCoordinate) {
              unmatched++;
              _pending.add(
                Pending(rest.name, null, keep: false, origin: Origin.file),
              );
              continue;
            }
            positioned++;
            _pending.add(
              Pending(rest.name, null, origin: Origin.file, fromFile: own),
            );
          }
          setState(() {
            _busy = false;
            _lookingUp = false;
            _status = [
              if (positioned > 0) l.fileImportPositioned(positioned),
              if (added > 0) l.fileImportSummary(added),
              if (unmatched > 0) '· ${l.importSummaryNeedLook(unmatched)}',
            ].join(' ');
          });
          return;
        }
        setState(() {
          _busy = false;
          _lookingUp = false;
          _status = e.throttled ? l.rateLimitedDuringImport(added) : e.message;
        });
        return;
      }
      if (!mounted) return;
      setState(() => _readCount++);

      if (matches.isEmpty) {
        // The map does not know it. If the file positioned it, that is still
        // enough to send elsewhere, so keep it rather than only counting it.
        if (own.hasCoordinate) {
          positioned++;
          _pending.add(
            Pending(place.name, null, origin: Origin.file, fromFile: own),
          );
        } else {
          unmatched++;
          _pending.add(
            Pending(place.name, null, keep: false, origin: Origin.file),
          );
        }
        continue;
      }
      if (!_pending.any((p) => p.match?.id == matches.first.id)) {
        _pending.add(
          Pending(
            place.name,
            matches.first,
            origin: Origin.file,
            // Kept even when the map answered: Apple's record has the better
            // coordinate, but if it arrives without one the file's still works.
            fromFile: own.hasCoordinate ? own : null,
          ),
        );
        added++;
      }
    }

    setState(() {
      _busy = false;
      _lookingUp = false;
      _status = [
        l.fileImportSummary(added),
        if (positioned > 0) '· ${l.fileImportPositioned(positioned)}',
        if (unmatched > 0) '· ${l.importSummaryNeedLook(unmatched)}',
        if (read.skipped > 0) '· ${l.fileImportSkipped(read.skipped)}',
      ].join(' ');
    });
  }

  /// Where to centre the search for one row of a file.
  ///
  /// The file's own coordinate wins when it has one: a per-place centre is
  /// strictly better than the batch region, and a file may span countries. The
  /// name is left empty so nothing invented is appended to the query — only the
  /// coordinate is a fact here.
  Region? _regionFor(FilePlace place) {
    final lat = place.lat, lon = place.lon;
    if (lat == null || lon == null) return _region;
    return Region(name: '', lat: lat, lon: lon);
  }

  Future<String?> _askGuideName(int count, {String? initial}) async {
    final l = L.of(context);
    final controller = TextEditingController(text: initial ?? '');
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

  /// The purchase sheet, in one of its two jobs.
  ///
  /// [carried] is how many places came out of a guide the user already keeps.
  /// When there are any, the sheet is selling the combined guide rather than the
  /// size cap, and it deliberately does **not** offer "save the first three
  /// instead": that option exists to trim what Wren found, and applying it here
  /// would publish a guide missing places the user already had. There is no
  /// smaller version of combining to fall back to.
  Future<_UnlockChoice> _offerUnlock(int selected, {int carried = 0}) async {
    final l = L.of(context);
    final price = await _store.price() ?? unlimitedFallbackPrice;
    if (!mounted) return _UnlockChoice.cancel;
    final combining = carried > 0;
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
                combining ? l.unlockCombineTitle : l.guidesOfAnySize,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 10),
              Text(
                combining
                    ? l.unlockCombineBody(carried)
                    : l.unlockExplain(freePlaceLimit, selected, over),
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
              if (!combining) ...[
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () =>
                      Navigator.pop(context, _UnlockChoice.publishFree),
                  child: Text(l.saveFirstInstead(freePlaceLimit)),
                ),
              ],
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

  /// Warns that a combined guide is a new guide, before one is made.
  ///
  /// Apple's guide link carries no guide identity, so there is nothing to add
  /// to — publishing always creates. Saying so beforehand is the difference
  /// between an understood limitation and an apparent duplicate.
  Future<bool> _confirmRepublish(int total) async {
    final l = L.of(context);
    final go = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          l.republishTitle,
          style: const TextStyle(fontFamily: Wren.serif),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l.republishBody(total),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            Text(
              l.republishThenDelete,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 14),
            // The list is not cleared after publishing, so a guide deleted in
            // error can be made again in one tap. Worth saying, because
            // "delete the old one" is otherwise a frightening instruction.
            Text(
              l.republishKeepsPlaces,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l.cancel, style: const TextStyle(color: Wren.muted)),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(minimumSize: const Size(0, 44)),
            child: Text(l.makeCombinedGuide),
          ),
        ],
      ),
    );
    return go ?? false;
  }

  /// Offers the places to another map app.
  ///
  /// Android only in practice: on iOS the destination is Apple Maps and that is
  /// what [_publish] already does. Named apps are listed first, but only if they
  /// are actually installed — and "installed" here means installed AND declared
  /// in the manifest's `<queries>`, because from Android 11 the two are the same
  /// answer. Anything not listed still reaches the same file through the system
  /// chooser, so the long tail works without Wren claiming to have tested it.
  Future<void> _sendPlacesElsewhere() async {
    final l = L.of(context);
    final places = [
      for (final p in _pending.where((p) => p.exportable)) p.forExport,
    ].whereType<ExportPlace>().toList();
    if (places.isEmpty) return;

    // Ask the platform which of the named apps are really there. One call per
    // app, all at once, before the sheet is drawn.
    final found = <String, String>{};
    for (final t in namedTargets) {
      final pkg = await _sharer.firstInstalled(t.packages);
      if (pkg != null) found[t.id] = pkg;
    }
    if (!mounted) return;

    final chosen = await showModalBottomSheet<MapTarget>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 2),
                child: Text(
                  l.sendPlacesTo,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Text(
                  l.sendPlacesReady(places.length),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              for (final t in namedTargets)
                if (found.containsKey(t.id))
                  ListTile(
                    leading: const Icon(Icons.place_outlined),
                    title: Text(t.name),
                    subtitle: t.note.isEmpty ? null : Text(t.note),
                    onTap: () => Navigator.pop(context, t),
                  ),
              // Google Maps is always offered, because the route is a web page
              // rather than an installed app.
              ListTile(
                leading: const Icon(Icons.public),
                title: Text(googleMapsTarget.name),
                subtitle: Text(googleMapsTarget.note),
                onTap: () => Navigator.pop(context, googleMapsTarget),
              ),
              const Divider(height: 8),
              ListTile(
                leading: const Icon(Icons.ios_share),
                title: Text(l.sendPlacesOtherApp),
                onTap: () => Navigator.pop(context, null),
              ),
            ],
          ),
        ),
      ),
    );
    if (!mounted) return;

    // Dismissed with the chooser row, or by swiping down. The chooser is the
    // safe default either way; a swipe simply does nothing.
    //
    // GPX for the chooser as well as for the named apps: it is what all of them
    // read as individual named places, and the one format that is never mistaken
    // for a route.
    final file = exportPlaces(
      places,
      chosen?.format ?? PlaceFormat.gpx,
      title: _guideName ?? 'Places',
    );

    if (chosen?.id == googleMapsTarget.id) {
      await _sendToGoogleMaps(file, l);
      return;
    }

    final outcome = chosen == null
        ? await _sharer.share(file, subject: _guideName ?? 'Places')
        : await _sharer.shareTo(file, chosen, found[chosen.id]!);
    if (!mounted) return;
    setState(() {
      _status = switch (outcome) {
        // "sent" is a hand-off, never an import: not one of these apps reports
        // back, so claiming success on their behalf would be a guess.
        ShareOutcome.sent => [
          l.sendPlacesReady(file.written),
          if (file.droppedForNoCoordinate > 0)
            '· ${l.sendPlacesNoLocation(file.droppedForNoCoordinate)}',
        ].join(' '),
        ShareOutcome.noHandler => l.sendPlacesFailed,
        ShareOutcome.unavailable => l.sendPlacesFailed,
      };
    });
  }

  /// The Google Maps route: a CSV, then My Maps in a Custom Tab.
  ///
  /// A CSV rather than a GPX because Google geocodes a name or address column
  /// itself on import, so nothing here needs a coordinate — which is the only
  /// reason this path costs nothing to run. The file goes to the share sheet
  /// first so it is somewhere the browser's file picker can reach it, and then
  /// the tab opens on the import page.
  Future<void> _sendToGoogleMaps(ExportResult file, L l) async {
    await _sharer.share(file, subject: _guideName ?? 'Places');
    if (!mounted) return;
    await _sharer.openTab(myMapsUrl(mapId: _myMapId));
    if (!mounted) return;
    setState(() => _status = l.sendPlacesReady(file.written));
  }

  Future<void> _publish() async {
    final l = L.of(context);

    // A batch that had to be split is still being handed over, one link per
    // trip to Maps. Finish it before building anything new, or the second half
    // of a guide would be replaced by a fresh first half.
    if (_queued.isNotEmpty) {
      await _open(_queued.removeAt(0), l);
      return;
    }

    var keep = _pending.where((p) => p.publishable).toList();
    if (keep.isEmpty) return;

    // Places carried over from an existing guide are not counted against the
    // size cap — the cap limits what Wren found, and counting them would make
    // importing a guide of twenty trip a limit built for three. Combining is
    // gated on its own instead, below, because it is the paid feature rather
    // than a bigger version of the free one.
    final billable = keep.where((p) => p.billable).length;
    final carried = keep.length - billable;

    // Nothing new, so there is nothing to add and republishing the guide
    // unchanged would only leave a duplicate in Maps. Checked before the
    // paywall, not after: offering the purchase first and finding this out
    // afterwards would have taken the money and made the duplicate anyway.
    if (billable == 0) {
      setState(() => _status = l.importGuideNothing);
      return;
    }

    // Combining needs the unlock, whatever the counts. Checked before the size
    // cap so someone with two carried places and one new is asked about the
    // thing they are actually doing.
    final block = carried > 0 && !_entitlement.unlimited
        ? PublishBlock.needsUnlock
        : _entitlement.check(billable);

    switch (block) {
      case PublishBlock.nothingSelected:
        return;
      case PublishBlock.needsUnlock:
        switch (await _offerUnlock(billable, carried: carried)) {
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
            // Only reachable when nothing was carried over — the sheet does not
            // offer this while combining, because trimming to the cap would
            // drop places out of a guide the user already had. Asserted rather
            // than assumed, since the two paths meet here.
            assert(carried == 0);
            keep = keep.where((p) => p.billable).take(freePlaceLimit).toList();
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
    if (places.length == 1 && carried == 0) {
      url = buildPlaceLink(places.single.id);
    } else {
      if (carried > 0 && !await _confirmRepublish(places.length)) return;
      if (!mounted) return;
      // Offered the old guide's name, since the combined guide is meant to
      // replace it. Still editable — the trip may have outgrown the name.
      final name = await _askGuideName(places.length, initial: _guideName);
      if (name == null) return;

      final links = buildGuideLinks(name, places);
      if (links.length > 1) {
        // This used to be `.first`, which published the first fifty places and
        // threw the rest away without a word. An 82-place guide imported from
        // Apple Maps would have lost thirty-two of them.
        if (!await _confirmSplit(links.length, places.length)) return;
        if (!mounted) return;
      }
      _queued
        ..clear()
        ..addAll(links);
      _queuedTotal = links.length;
      url = _queued.removeAt(0);
    }

    await _open(url, l);
  }

  /// Hands one link to Apple Maps and says where that leaves things.
  Future<void> _open(String url, L l) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      setState(() => _status = l.couldNotOpenMaps);
      return;
    }
    if (!mounted) return;
    if (_queued.isNotEmpty) {
      // Maps takes one link per trip, so the rest wait behind the same button.
      setState(
        () => _status = l.splitProgress(
          _queuedTotal - _queued.length,
          _queuedTotal,
        ),
      );
    } else {
      _queuedTotal = 0;
    }
  }

  /// Explains why several guides are about to appear instead of one.
  Future<bool> _confirmSplit(int guides, int places) async {
    final l = L.of(context);
    final go = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          l.splitTitle,
          style: const TextStyle(fontFamily: Wren.serif),
        ),
        content: Text(
          l.splitBody(guides, places),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l.cancel, style: const TextStyle(color: Wren.muted)),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(minimumSize: const Size(0, 44)),
            child: Text(l.splitConfirm(guides)),
          ),
        ],
      ),
    );
    return go ?? false;
  }

  /// Which of the three sources to add from.
  Future<void> _addPlaces() async {
    final l = L.of(context);
    final choice = await showModalBottomSheet<_AddSource>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.add_photo_alternate_outlined),
              title: Text(l.addScreenshots),
              onTap: () => Navigator.pop(context, _AddSource.screenshots),
            ),
            ListTile(
              leading: const Icon(Icons.insert_drive_file_outlined),
              title: Text(l.fromFile),
              onTap: () => Navigator.pop(context, _AddSource.file),
            ),
            ListTile(
              leading: const Icon(Icons.bookmark_border),
              title: Text(l.fromExistingGuide),
              onTap: () => Navigator.pop(context, _AddSource.guide),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
    if (choice == null || !mounted) return;
    switch (choice) {
      case _AddSource.screenshots:
        await _importScreenshots();
      case _AddSource.file:
        await _importFile();
      case _AddSource.guide:
        await _importGuide();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = L.of(context);
    final keeping = _pending.where((p) => p.publishable).length;
    // Not the same count: a place a file positioned can be sent to another map
    // app without Apple ever having identified it.
    final sendable = _pending.where((p) => p.exportable).length;
    final unresolved = _pending.where((p) => !p.resolved).length;
    // The free limit applies to what Wren found, not to what the user already
    // had, so the banner counts the same thing the paywall does.
    final over = _entitlement.overBy(
      _pending.where((p) => p.publishable && p.billable).length,
    );

    // Carried-over places sit in one collapsed group. Two lists over one index
    // arithmetic: the group is a single row when closed and n rows when open,
    // and offsetting an itemBuilder by that is how off-by-one bugs get in.
    final carried = _pending.where((p) => p.origin == Origin.guide).toList();
    final fresh = _pending.where((p) => p.origin != Origin.guide).toList();

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
        title: GestureDetector(
          // Long press opens complimentary access. Undiscoverable on purpose,
          // and useless without a code that the server recognises.
          onLongPress: _compUnlock,
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
          // The menu is always present now. It used to appear only when the
          // unlock had not been bought, which meant clearing the list would
          // have been unreachable for anyone who had paid.
          PopupMenuButton<String>(
            onSelected: (v) {
              if (v == 'restore') _restoreFromMenu();
              if (v == 'clear') _clearList();
              if (v == 'send') _sendPlacesElsewhere();
            },
            itemBuilder: (context) => [
              // Android only. On iOS the destination is Apple Maps, which the
              // main button already does, and offering to "send elsewhere" there
              // would mean offering a file nothing on the phone wants.
              if (Platform.isAndroid && sendable > 0)
                PopupMenuItem(value: 'send', child: Text(l.sendPlacesTo)),
              if (_pending.isNotEmpty)
                PopupMenuItem(value: 'clear', child: Text(l.clearList)),
              if (!_entitlement.unlimited)
                PopupMenuItem(value: 'restore', child: Text(l.restorePurchase)),
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
                _lookingUp
                    ? l.lookingUpProgress(_readCount, _totalCount)
                    : l.readingProgress(_readCount, _totalCount),
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
          // Said as soon as a guide has been read in, not at the end. Finding
          // out after choosing places and naming the guide would be a worse way
          // to learn it.
          if (carried.isNotEmpty && !_entitlement.unlimited)
            _Banner(
              accent: Wren.clay,
              child: Text(
                l.combineNeedsUnlock,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          Expanded(
            child: _pending.isEmpty
                ? const _Empty()
                : ListView(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    children: [
                      if (carried.isNotEmpty) ...[
                        _CarriedGroup(
                          count: carried.length,
                          guideName: _guideName,
                          expanded: _showCarried,
                          // Apple's payload carries no names, so until the
                          // lookup fills them in there is nothing behind the
                          // toggle. Offering it anyway would open onto a column
                          // of blank cards.
                          canExpand: carried.any(
                            (p) =>
                                (p.match?.name ?? '').isNotEmpty ||
                                (p.match?.address ?? '').isNotEmpty,
                          ),
                          onTap: () =>
                              setState(() => _showCarried = !_showCarried),
                        ),
                        const SizedBox(height: 10),
                        if (_showCarried && carried.isNotEmpty)
                          for (final p in carried) ...[
                            _PlaceCard(
                              pending: p,
                              onChanged: (v) =>
                                  setState(() => p.keep = v ?? true),
                              onEdit: () => _editPlace(_pending.indexOf(p)),
                            ),
                            const SizedBox(height: 10),
                          ],
                      ],
                      for (final p in fresh) ...[
                        _PlaceCard(
                          pending: p,
                          onChanged: (v) => setState(() => p.keep = v ?? true),
                          onEdit: () => _editPlace(_pending.indexOf(p)),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ],
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
                      onPressed: _busy ? null : _addPlaces,
                      icon: const Icon(Icons.add, size: 20),
                      label: Text(_busy ? l.readingShort : l.addPlaces),
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

enum _AddSource { screenshots, file, guide }

/// Which overlay the store-screenshot build should open on launch.
enum ScreenshotOverlay { none, region, paywall, search, addMenu }

/// The collapsed group holding places carried over from an existing guide.
///
/// Collapsed by default, and it is the reason the group exists: importing a
/// guide of forty places would otherwise bury the two just added under a list
/// the user has already seen in Maps. Open, it is an ordinary list of cards.
class _CarriedGroup extends StatelessWidget {
  const _CarriedGroup({
    required this.count,
    required this.guideName,
    required this.expanded,
    required this.canExpand,
    required this.onTap,
  });

  final int count;
  final String? guideName;
  final bool expanded;

  /// Whether there is anything behind the toggle yet.
  final bool canExpand;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l = L.of(context);
    final t = Theme.of(context).textTheme;
    final name = guideName;

    return Material(
      color: Wren.raised,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Wren.line),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: canExpand ? onTap : null,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 10, 12),
          child: Row(
            children: [
              const Icon(Icons.bookmark_border, size: 18, color: Wren.muted),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.alreadyInGuide(count),
                      style: t.titleMedium?.copyWith(fontSize: 16),
                    ),
                    if (name != null && name.isNotEmpty) ...[
                      const SizedBox(height: 3),
                      Text(
                        l.fromGuideNamed(name),
                        style: t.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              if (canExpand)
                Icon(
                  expanded ? Icons.expand_less : Icons.expand_more,
                  color: Wren.muted,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

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
    // A place the file positioned itself. Apple has not identified it, so it
    // cannot go into a guide -- but it has a name and an address, and showing
    // "Not found on the map. Tap to search for it." would be doubly wrong: the
    // place is not lost, and on a platform with no map search there is nothing
    // for a tap to do.
    final fromFile = pending.fromFile;
    final shown = resolved
        ? (match.name.isNotEmpty ? match.name : match.address)
        : (fromFile?.name ?? '');
    final shownAddress = resolved ? match.address : (fromFile?.address ?? '');
    final named = shown.isNotEmpty;

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
                      if (named) ...[
                        // A carried place arrives with a muid and no name. If
                        // the lookup filled one in, use it; failing that the
                        // address is still something true. The group refuses to
                        // expand when neither exists, so this never renders
                        // blank.
                        Text(shown, style: t.titleMedium),
                        // A place carried over from a guide has no address in
                        // the payload, so the line is left out rather than
                        // rendered blank.
                        if (shownAddress.isNotEmpty) ...[
                          const SizedBox(height: 3),
                          Text(shownAddress, style: t.bodySmall),
                        ],
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
                      // Shown for anything Wren had to interpret, matched or
                      // not: it is the only way to tell a right match from a
                      // confident wrong one. Omitted for a place carried over
                      // from a guide, where the name came from Apple's own
                      // record and repeating it says nothing.
                      if (pending.origin != Origin.guide) ...[
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
            Text(l.emptyBody, style: t.bodyMedium, textAlign: TextAlign.center),
            const SizedBox(height: 18),
            Text(l.emptyNote, style: t.bodySmall, textAlign: TextAlign.center),
            const SizedBox(height: 18),
            // Named here rather than left to be found inside a menu. A file
            // importer nobody knows the formats of is a file importer nobody
            // tries, and the formats are the whole answer to "will mine work".
            Container(
              padding: const EdgeInsets.fromLTRB(14, 11, 14, 11),
              decoration: BoxDecoration(
                color: Wren.raised,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Wren.line),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.insert_drive_file_outlined,
                    size: 15,
                    color: Wren.muted,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      l.acceptedFormats,
                      style: t.bodySmall?.copyWith(fontSize: 12.5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
