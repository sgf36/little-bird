/// The code console: issuing and withdrawing complimentary codes from a phone.
///
/// Reached by the same long press on the app name that opens the code box, but
/// only on a device that has redeemed an admin code. Everyone else — including
/// somebody who has redeemed an ordinary code, and somebody who has paid — gets
/// the code box, exactly as before. There is no menu item, no setting and no
/// disabled control anywhere in the app that hints this exists, which is the
/// point: the feature is invisible rather than merely protected.
///
/// Deliberately not translated, and the only screen in Wren that is not.
///
/// Every other string in the app is in fifty ARB catalogues because every other
/// string is read by strangers. This one is read by whoever runs Wren and by
/// the handful of people they hand an admin code to, and its vocabulary — uses,
/// withdrawn, spent — is operational rather than ordinary. Machine-translating
/// that into forty-six languages would put words nobody has checked in front of
/// the one person with nobody to ask what they mean.
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'admin_codes.dart';
import 'comp_unlock.dart' show CompRole;
import 'theme.dart';

/// Opens the console. Returns when it is closed.
Future<void> showAdminSheet(BuildContext context, String token) =>
    Navigator.of(context).push<void>(
      MaterialPageRoute(builder: (_) => AdminSheet(codes: AdminCodes(token))),
    );

class AdminSheet extends StatefulWidget {
  const AdminSheet({super.key, required this.codes});

  final AdminCodes codes;

  @override
  State<AdminSheet> createState() => _AdminSheetState();
}

class _AdminSheetState extends State<AdminSheet> {
  late Future<List<CodeRecord>> _codes = widget.codes.list();

  /// A block body, not an arrow. `setState(() => _codes = ...)` returns the
  /// future it just assigned, and Flutter treats a setState callback with a
  /// return value as an asynchronous one and throws — which the console then
  /// reported as the server having answered strangely.
  void _reload() {
    setState(() {
      _codes = widget.codes.list();
    });
  }

  /// Sentences rather than error names. Withdrawal and "never was an
  /// administrator" read the same here because they read the same upstream.
  static String _explain(Object error) => switch (error) {
    AdminException(failure: AdminFailure.notPermitted) =>
      'This device is no longer permitted to issue codes.',
    AdminException(failure: AdminFailure.wouldRevokeSelf) =>
      'That is the code this device is using. Withdraw it from a terminal.',
    AdminException(failure: AdminFailure.unreachable) =>
      'Could not reach the server. Check your connection and try again.',
    _ => 'The server answered with something unexpected.',
  };

  void _say(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _mint() async {
    final request = await showDialog<_MintRequest>(
      context: context,
      builder: (_) => const _MintDialog(),
    );
    if (request == null || !mounted) return;
    try {
      final minted = await widget.codes.mint(
        role: request.role,
        count: request.count,
        maxUses: request.maxUses,
        note: request.note,
      );
      if (!mounted) return;
      _reload();
      await showDialog<void>(
        context: context,
        builder: (_) => _MintedDialog(codes: minted, role: request.role),
      );
    } on Object catch (error) {
      _say(_explain(error));
    }
  }

  Future<void> _revoke(CodeRecord record) async {
    final go = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Withdraw this code?',
          style: TextStyle(fontFamily: Wren.serif),
        ),
        // Says what withdrawing does not do, because the obvious reading is
        // that it takes the unlock back, and it cannot: an entitlement is a
        // signed token on somebody else's phone, checked without a network.
        content: Text(
          record.uses == 0
              ? 'It stops working for anyone who redeems it later. Nobody has yet.'
              : 'It stops working from now on. Anyone who has already redeemed '
                    'it keeps their access.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel', style: TextStyle(color: Wren.muted)),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              minimumSize: const Size(0, 44),
              backgroundColor: Wren.clay,
            ),
            child: const Text('Withdraw'),
          ),
        ],
      ),
    );
    if (go != true || !mounted) return;
    try {
      await widget.codes.revoke(record.code);
      _reload();
    } on Object catch (error) {
      _say(_explain(error));
    }
  }

  Future<void> _copy(String code) async {
    await Clipboard.setData(ClipboardData(text: code));
    _say('Copied.');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Codes', style: TextStyle(fontFamily: Wren.serif)),
      actions: [
        IconButton(
          onPressed: _reload,
          icon: const Icon(Icons.refresh),
          tooltip: 'Refresh',
        ),
        IconButton(
          onPressed: _mint,
          icon: const Icon(Icons.add),
          tooltip: 'New code',
        ),
        const SizedBox(width: 4),
      ],
    ),
    body: FutureBuilder<List<CodeRecord>>(
      future: _codes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return _Centred(_explain(snapshot.error!));
        }
        final codes = snapshot.data ?? const <CodeRecord>[];
        if (codes.isEmpty) {
          return const _Centred('No codes have been issued yet.');
        }
        return RefreshIndicator(
          onRefresh: () async => _reload(),
          child: ListView.separated(
            itemCount: codes.length,
            separatorBuilder: (_, _) =>
                const Divider(height: 1, color: Wren.line),
            itemBuilder: (context, i) => _CodeTile(
              record: codes[i],
              onCopy: () => _copy(codes[i].code),
              onRevoke: () => _revoke(codes[i]),
            ),
          ),
        );
      },
    ),
  );
}

class _Centred extends StatelessWidget {
  const _Centred(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(28),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    ),
  );
}

class _CodeTile extends StatelessWidget {
  const _CodeTile({
    required this.record,
    required this.onCopy,
    required this.onRevoke,
  });

  final CodeRecord record;
  final VoidCallback onCopy;
  final VoidCallback onRevoke;

  /// The one line saying what state a code is in. Withdrawn beats spent beats
  /// expired: a code can be all three, and only the first of them matters to
  /// somebody deciding whether it is still worth sending to anyone.
  String get _state {
    if (record.revoked) return 'Withdrawn';
    if (record.spent) return 'Spent';
    final expires = record.expiresAt;
    if (expires != null && expires.isBefore(DateTime.now())) return 'Expired';
    if (record.maxUses == 1) return record.uses == 0 ? 'Unused' : 'Used';
    return '${record.uses} of ${record.maxUses} used';
  }

  @override
  Widget build(BuildContext context) {
    final admin = record.role == CompRole.admin;
    return ListTile(
      onTap: onCopy,
      title: Row(
        children: [
          Flexible(
            child: Text(
              record.code,
              style: const TextStyle(
                fontFamily: 'Courier',
                fontSize: 15.5,
                letterSpacing: 0.4,
                color: Wren.text,
              ),
            ),
          ),
          // Only administrators are badged. Badging both would put a label on
          // every row and make the rare one harder to spot, not easier.
          if (admin)
            Container(
              margin: const EdgeInsetsDirectional.only(start: 8),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Wren.clay,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'ADMIN',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                  color: Wren.ground,
                ),
              ),
            ),
        ],
      ),
      subtitle: Text(
        record.note.isEmpty ? _state : '$_state · ${record.note}',
        style: TextStyle(
          fontSize: 13,
          color: record.live ? Wren.muted : Wren.placeholder,
        ),
      ),
      trailing: record.revoked
          ? null
          : IconButton(
              onPressed: onRevoke,
              icon: const Icon(Icons.block, size: 20, color: Wren.muted),
              tooltip: 'Withdraw',
            ),
    );
  }
}

class _MintRequest {
  const _MintRequest({
    required this.role,
    required this.count,
    required this.maxUses,
    required this.note,
  });

  final CompRole role;
  final int count;
  final int maxUses;
  final String note;
}

class _MintDialog extends StatefulWidget {
  const _MintDialog();

  @override
  State<_MintDialog> createState() => _MintDialogState();
}

class _MintDialogState extends State<_MintDialog> {
  CompRole _role = CompRole.unlock;
  final _count = TextEditingController(text: '1');
  final _uses = TextEditingController(text: '1');
  final _note = TextEditingController();

  @override
  void dispose() {
    _count.dispose();
    _uses.dispose();
    _note.dispose();
    super.dispose();
  }

  /// Whatever was typed, held to what the server would accept anyway, so a
  /// stray keystroke is a sensible number rather than a refusal.
  static int _number(TextEditingController field, int fallback, int cap) {
    final parsed = int.tryParse(field.text.trim()) ?? fallback;
    return parsed.clamp(1, cap);
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('New code', style: TextStyle(fontFamily: Wren.serif)),
    content: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SegmentedButton<CompRole>(
            segments: const [
              ButtonSegment(value: CompRole.unlock, label: Text('Unlock')),
              ButtonSegment(value: CompRole.admin, label: Text('Admin')),
            ],
            selected: {_role},
            onSelectionChanged: (chosen) =>
                setState(() => _role = chosen.first),
          ),
          const SizedBox(height: 8),
          // Said plainly, because the difference is not recoverable: an admin
          // code hands over the ability to give the paid feature away.
          Text(
            _role == CompRole.admin
                ? 'Unlocks the app, and lets whoever redeems it issue codes of '
                      'their own.'
                : 'Unlocks the app. Nothing else.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _count,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'How many'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _uses,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Uses each'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _note,
            autocorrect: false,
            decoration: const InputDecoration(
              labelText: 'Note',
              hintText: 'Who it is for',
            ),
          ),
        ],
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancel', style: TextStyle(color: Wren.muted)),
      ),
      FilledButton(
        onPressed: () => Navigator.pop(
          context,
          _MintRequest(
            role: _role,
            count: _number(_count, 1, 200),
            maxUses: _number(_uses, 1, 10000),
            note: _note.text.trim(),
          ),
        ),
        style: FilledButton.styleFrom(minimumSize: const Size(0, 44)),
        child: const Text('Create'),
      ),
    ],
  );
}

class _MintedDialog extends StatelessWidget {
  const _MintedDialog({required this.codes, required this.role});

  final List<String> codes;
  final CompRole role;

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(
      codes.length == 1 ? 'Code issued' : '${codes.length} codes issued',
      style: const TextStyle(fontFamily: Wren.serif),
    ),
    content: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (role == CompRole.admin)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                'These grant the code console as well as the unlock.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          for (final code in codes)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: SelectableText(
                code,
                style: const TextStyle(
                  fontFamily: 'Courier',
                  fontSize: 16,
                  letterSpacing: 0.6,
                  color: Wren.text,
                ),
              ),
            ),
        ],
      ),
    ),
    actions: [
      TextButton(
        onPressed: () async {
          await Clipboard.setData(ClipboardData(text: codes.join('\n')));
          if (context.mounted) Navigator.pop(context);
        },
        child: const Text('Copy'),
      ),
      FilledButton(
        onPressed: () => Navigator.pop(context),
        style: FilledButton.styleFrom(minimumSize: const Size(0, 44)),
        child: const Text('Done'),
      ),
    ],
  );
}
