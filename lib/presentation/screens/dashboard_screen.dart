import 'package:flutter/material.dart';
import 'package:app_cantera/l10n/generated/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../domain/providers/auth_provider.dart';
import '../../domain/providers/match_provider.dart';
import '../../domain/providers/notice_provider.dart';
import '../widgets/match_card.dart';
import 'home_screen.dart' show homeTabProvider;

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final auth = ref.watch(authProvider);
    final nextMatch = ref.watch(nextMatchProvider);
    final urgentNotices = ref.watch(urgentNoticesProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          // Urgent banner
          if (urgentNotices.isNotEmpty)
            MaterialBanner(
              backgroundColor: Colors.red.shade50,
              leading: const Icon(
                Icons.warning_amber_rounded,
                color: Colors.red,
              ),
              content: Text(
                urgentNotices.first.title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    ref
                        .read(noticeProvider.notifier)
                        .confirmRead(urgentNotices.first.noticeId);
                  },
                  child: Text(l10n.confirmRead),
                ),
              ],
            ),

          // Welcome message
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Text(
              l10n.welcomeBack(auth.userName),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Next match card
          if (nextMatch != null) ...[
            const SizedBox(height: 8),
            MatchCard(match: nextMatch),
          ],

          // Quick access grid
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
            child: Text(
              l10n.quickAccess,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.6,
              children: [
                _QuickAccessCard(
                  icon: Icons.directions_car,
                  label: l10n.navCarpool,
                  color: AppTheme.primaryBlue,
                  onTap: () => _navigateToTab(context, ref, 2),
                ),
                _QuickAccessCard(
                  icon: Icons.notifications,
                  label: l10n.navComms,
                  color: Colors.orange,
                  onTap: () => _navigateToTab(context, ref, 1),
                ),
                _QuickAccessCard(
                  icon: Icons.calendar_today,
                  label: l10n.schedule,
                  color: AppTheme.accentGreen,
                  onTap: () => _navigateToTab(context, ref, 1),
                ),
                _QuickAccessCard(
                  icon: Icons.description,
                  label: l10n.regulations,
                  color: Colors.grey[700]!,
                  onTap: () => _navigateToTab(context, ref, 3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToTab(BuildContext context, WidgetRef ref, int tabIndex) {
    ref.read(homeTabProvider.notifier).state = tabIndex;
  }
}

class _QuickAccessCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  const _QuickAccessCard({
    required this.icon,
    required this.label,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
