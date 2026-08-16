import 'dart:async';

import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import 'resolver.dart';
import 'theme.dart';

/// Live lookup against Apple Maps, for fixing what OCR read or finding what it
/// could not.
///
/// Opened for two cases and deliberately the same screen for both: correcting a
/// match Apple got wrong, and finding a place that never matched at all. In
/// both, what the screenshot actually said stays on screen — it is the only
/// record of what the user meant, and retyping it from memory is the thing this
/// app exists to avoid.
///
/// Typing is debounced rather than searched per keystroke. MapKit throttles
/// bursts with MKError 4, and a search per character is exactly the burst that
/// triggers it.
class PlaceSearchSheet extends StatefulWidget {
  const PlaceSearchSheet({
    super.key,
    required this.readAs,
    required this.resolver,
    this.region,
    this.initialQuery,
  });

  /// What OCR read from the screenshot. Never editable — it is evidence.
  final String readAs;
  final PlaceResolver resolver;
  final Region? region;
  final String? initialQuery;

  @override
  State<PlaceSearchSheet> createState() => _PlaceSearchSheetState();
}

class _PlaceSearchSheetState extends State<PlaceSearchSheet> {
  static const _debounce = Duration(milliseconds: 450);

  late final TextEditingController _controller = TextEditingController(
    text: widget.initialQuery ?? widget.readAs,
  );
  Timer? _timer;
  int _generation = 0;
  List<PlaceMatch> _results = const [];
  bool _searching = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _search(_controller.text);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _timer?.cancel();
    _timer = Timer(_debounce, () => _search(value));
  }

  Future<void> _search(String raw) async {
    final query = raw.trim();
    if (query.length < 2) {
      setState(() {
        _results = const [];
        _searching = false;
        _error = null;
      });
      return;
    }

    // Anything already in flight is stale the moment the query changes.
    final mine = ++_generation;
    setState(() {
      _searching = true;
      _error = null;
    });

    try {
      final found = usable(
        await widget.resolver.resolve(query, region: widget.region),
      );
      if (!mounted || mine != _generation) return;
      setState(() {
        _results = found;
        _searching = false;
      });
    } on ResolverUnavailable catch (e) {
      if (!mounted || mine != _generation) return;
      final l = L.of(context);
      setState(() {
        _searching = false;
        _error = e.throttled
            ? l.rateLimited
            : e.unsupported
            ? l.lookupUnavailable
            : e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = L.of(context);
    final t = Theme.of(context).textTheme;
    final insets = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: insets),
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.75,
        minChildSize: 0.45,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l.findThisPlace, style: t.headlineMedium),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.text_fields,
                        size: 14,
                        color: Wren.muted,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          l.readAs(widget.readAs),
                          style: t.bodySmall,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: _controller,
                    autofocus: true,
                    textInputAction: TextInputAction.search,
                    onChanged: _onChanged,
                    onSubmitted: _search,
                    decoration: InputDecoration(
                      labelText: widget.region == null
                          ? l.searchAppleMaps
                          : l.searchInRegion(widget.region!.name),
                      suffixIcon: _searching
                          ? const Padding(
                              padding: EdgeInsets.all(14),
                              child: SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Wren.muted,
                                ),
                              ),
                            )
                          : IconButton(
                              icon: const Icon(Icons.search, color: Wren.muted),
                              onPressed: () => _search(_controller.text),
                            ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Wren.line),
            Expanded(
              child: _error != null
                  ? _Message(text: _error!, tone: Wren.danger)
                  : _results.isEmpty
                  ? _Message(
                      text: _searching
                          ? l.searching
                          : _controller.text.trim().length < 2
                          ? l.typeTwoCharacters
                          : l.nothingFound,
                      tone: Wren.muted,
                    )
                  : ListView.separated(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: _results.length,
                      separatorBuilder: (_, _) =>
                          const Divider(height: 1, color: Wren.line),
                      itemBuilder: (context, i) {
                        final m = _results[i];
                        return ListTile(
                          title: Text(m.name, style: t.titleMedium),
                          subtitle: Text(
                            [
                              m.address,
                              if (m.category != null) m.category,
                            ].whereType<String>().join(' · '),
                            style: t.bodySmall,
                          ),
                          trailing: const Icon(
                            Icons.add_circle_outline,
                            color: Wren.gold,
                          ),
                          onTap: () => Navigator.pop(context, m),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({required this.text, required this.tone});
  final String text;
  final Color tone;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: tone),
      ),
    ),
  );
}
