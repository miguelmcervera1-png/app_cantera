import 'package:flutter/material.dart';
import 'package:app_cantera/l10n/generated/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../core/theme/app_theme.dart';
import '../../data/mock/mock_data.dart';
import '../../data/models/notice_model.dart';
import '../../domain/providers/auth_provider.dart';
import '../../domain/providers/locale_provider.dart';
import '../../domain/providers/notice_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final locale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navSettings)),
      body: ListView(
        children: [
          // Language section
          _SectionHeader(title: l10n.language),
          ListTile(
            leading: Icon(
              locale.languageCode == 'es'
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: locale.languageCode == 'es'
                  ? AppTheme.primaryBlue
                  : null,
            ),
            title: Text(l10n.spanish),
            subtitle: const Text('Español'),
            onTap: () {
              ref.read(localeProvider.notifier).state = const Locale('es');
            },
          ),
          ListTile(
            leading: Icon(
              locale.languageCode == 'en'
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: locale.languageCode == 'en'
                  ? AppTheme.primaryBlue
                  : null,
            ),
            title: Text(l10n.english),
            subtitle: const Text('English'),
            onTap: () {
              ref.read(localeProvider.notifier).state = const Locale('en');
            },
          ),

          const Divider(height: 32),

          // Regulations section
          _SectionHeader(title: l10n.regulations),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: Text(l10n.privacyTitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showLegalDialog(
              context,
              l10n.privacyTitle,
              l10n.privacyBody,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: Text(l10n.termsTitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showLegalDialog(
              context,
              l10n.termsTitle,
              l10n.termsBody,
            ),
          ),

          const Divider(height: 32),

          // Admin mock panel
          _SectionHeader(title: l10n.adminPanel),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: OutlinedButton.icon(
              onPressed: () => _showAdminPanel(context, ref, l10n),
              icon: const Icon(Icons.send),
              label: Text(l10n.sendNotice),
            ),
          ),

          const Divider(height: 32),

          // Logout
          Padding(
            padding: const EdgeInsets.all(16),
            child: FilledButton.icon(
              onPressed: () => _confirmLogout(context, ref, l10n),
              icon: const Icon(Icons.logout),
              label: Text(l10n.logout),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLegalDialog(BuildContext context, String title, String body) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(child: Text(body)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _confirmLogout(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.logout),
        content: Text(l10n.logoutConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.no),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              ref.read(authProvider.notifier).logout();
            },
            child: Text(l10n.yes),
          ),
        ],
      ),
    );
  }

  void _showAdminPanel(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _AdminPanelSheet(l10n: l10n),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: AppTheme.primaryBlue,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _AdminPanelSheet extends ConsumerStatefulWidget {
  final AppLocalizations l10n;

  const _AdminPanelSheet({required this.l10n});

  @override
  ConsumerState<_AdminPanelSheet> createState() => _AdminPanelSheetState();
}

class _AdminPanelSheetState extends ConsumerState<_AdminPanelSheet> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  NoticeCategory _category = NoticeCategory.informative;
  String _targetTeam = 'all';
  bool _requiresConfirmation = false;

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = widget.l10n;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        24,
        24,
        24,
        24 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.adminPanel,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: l10n.noticeTitle,
                prefixIcon: const Icon(Icons.title),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _bodyController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: l10n.noticeBody,
                prefixIcon: const Icon(Icons.notes),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<NoticeCategory>(
              initialValue: _category,
              decoration: InputDecoration(
                labelText: l10n.selectCategory,
                prefixIcon: const Icon(Icons.label),
              ),
              items: [
                DropdownMenuItem(
                  value: NoticeCategory.urgent,
                  child: Text(l10n.categoryUrgent),
                ),
                DropdownMenuItem(
                  value: NoticeCategory.informative,
                  child: Text(l10n.categoryInfo),
                ),
                DropdownMenuItem(
                  value: NoticeCategory.callup,
                  child: Text(l10n.categoryCallup),
                ),
              ],
              onChanged: (v) => setState(() => _category = v!),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _targetTeam,
              decoration: InputDecoration(
                labelText: l10n.selectTeam,
                prefixIcon: const Icon(Icons.group),
              ),
              items: [
                DropdownMenuItem(
                  value: 'all',
                  child: Text(l10n.allTeams),
                ),
                ...MockData.teams.map(
                  (team) =>
                      DropdownMenuItem(value: team, child: Text(team)),
                ),
              ],
              onChanged: (v) => setState(() => _targetTeam = v!),
            ),
            const SizedBox(height: 8),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.requiresConfirmation),
              value: _requiresConfirmation,
              onChanged: (v) => setState(() => _requiresConfirmation = v),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _sendNotice,
              icon: const Icon(Icons.send),
              label: Text(l10n.sendNotice),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _sendNotice() {
    if (_titleController.text.trim().isEmpty) return;

    final notice = NoticeModel(
      noticeId: const Uuid().v4(),
      category: _category,
      targetTeam: _targetTeam,
      title: _titleController.text.trim(),
      body: _bodyController.text.trim(),
      timestamp: DateTime.now(),
      requiresConfirmation: _requiresConfirmation,
    );

    ref.read(noticeProvider.notifier).addNotice(notice);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(widget.l10n.noticeSent)),
    );
  }
}
