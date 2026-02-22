import 'package:flutter/material.dart';
import 'package:app_cantera/l10n/generated/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../domain/providers/auth_provider.dart';
import '../../domain/providers/locale_provider.dart';
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
    final locale = ref.watch(localeProvider);
    final isEs = locale.languageCode == 'es';

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // ── Hero header with gradient ──
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(
              24,
              MediaQuery.of(context).padding.top + 20,
              24,
              32,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppTheme.darkNavy, AppTheme.primaryBlue],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x40001A3A),
                  blurRadius: 20,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/espanyol_logo.png',
                  height: 80,
                ),
                const SizedBox(height: 12),
                const Text(
                  'LA 21',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 3.0,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.accentGold.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppTheme.accentGold.withValues(alpha: 0.4),
                    ),
                  ),
                  child: Text(
                    auth.userTeam,
                    style: const TextStyle(
                      color: AppTheme.accentGold,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  l10n.welcomeBack(auth.userName),
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // ── Urgent banner ──
          if (urgentNotices.isNotEmpty)
            Card(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              color: Colors.red.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Colors.red, width: 0),
              ),
              clipBehavior: Clip.antiAlias,
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    left: BorderSide(color: Colors.red, width: 4),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          urgentNotices.first.title,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(width: 8),
                      FilledButton.tonal(
                        onPressed: () {
                          ref
                              .read(noticeProvider.notifier)
                              .confirmRead(urgentNotices.first.noticeId);
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.red.shade100,
                          foregroundColor: Colors.red.shade700,
                          minimumSize: Size.zero,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        child: Text(l10n.confirmRead),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // ── Next match section ──
          if (nextMatch != null) ...[
            _SectionHeader(title: l10n.nextMatch),
            MatchCard(match: nextMatch),
          ],

          // ── Quick access section ──
          _SectionHeader(title: l10n.quickAccess),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _QuickAccessCard(
                        icon: Icons.directions_car,
                        label: l10n.navCarpool,
                        description: isEs ? 'Coordina trayectos' : 'Coordinate rides',
                        color: AppTheme.primaryBlue,
                        onTap: () => _navigateToTab(ref, 2),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _QuickAccessCard(
                        icon: Icons.notifications,
                        label: l10n.navComms,
                        description: isEs ? 'Avisos y novedades' : 'Notices & updates',
                        color: const Color(0xFFE67E22),
                        onTap: () => _navigateToTab(ref, 1),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _QuickAccessCard(
                        icon: Icons.calendar_today,
                        label: l10n.schedule,
                        description: isEs ? 'Entrenos y partidos' : 'Training & matches',
                        color: AppTheme.accentGreen,
                        onTap: () => _navigateToTab(ref, 1),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _QuickAccessCard(
                        icon: Icons.description,
                        label: l10n.regulations,
                        description: isEs ? 'Normas del club' : 'Club rules',
                        color: const Color(0xFF6C757D),
                        onTap: () => _navigateToTab(ref, 3),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _navigateToTab(WidgetRef ref, int tabIndex) {
    ref.read(homeTabProvider.notifier).state = tabIndex;
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              gradient: AppTheme.accentGradient,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title.toUpperCase(),
            style: AppTheme.sectionHeaderStyle,
          ),
        ],
      ),
    );
  }
}

class _QuickAccessCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String description;
  final Color color;
  final VoidCallback? onTap;

  const _QuickAccessCard({
    required this.icon,
    required this.label,
    required this.description,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: color.withValues(alpha: 0.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.darkNavy,
                color.withValues(alpha: 0.85),
              ],
            ),
          ),
          child: Stack(
            children: [
              // Escudo de fondo semitransparente
              Positioned(
                right: -8,
                bottom: -8,
                child: Opacity(
                  opacity: 0.06,
                  child: Image.asset(
                    'assets/images/espanyol_logo.png',
                    height: 72,
                    color: Colors.white,
                    colorBlendMode: BlendMode.srcIn,
                  ),
                ),
              ),
              // Contenido
              Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(icon, color: Colors.white, size: 22),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            label,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            description,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
