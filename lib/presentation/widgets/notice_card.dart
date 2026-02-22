import 'package:flutter/material.dart';
import 'package:app_cantera/l10n/generated/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_theme.dart';
import '../../data/models/notice_model.dart';

class NoticeCard extends StatelessWidget {
  final NoticeModel notice;
  final VoidCallback? onConfirmRead;

  const NoticeCard({super.key, required this.notice, this.onConfirmRead});

  Color _categoryColor() {
    switch (notice.category) {
      case NoticeCategory.urgent:
        return Colors.red.shade300;
      case NoticeCategory.informative:
        return AppTheme.accentGold;
      case NoticeCategory.callup:
        return AppTheme.accentGreen;
    }
  }

  IconData _categoryIcon() {
    switch (notice.category) {
      case NoticeCategory.urgent:
        return Icons.warning_amber_rounded;
      case NoticeCategory.informative:
        return Icons.info_outline;
      case NoticeCategory.callup:
        return Icons.assignment_turned_in;
    }
  }

  String _categoryLabel(AppLocalizations l10n) {
    switch (notice.category) {
      case NoticeCategory.urgent:
        return l10n.categoryUrgent;
      case NoticeCategory.informative:
        return l10n.categoryInfo;
      case NoticeCategory.callup:
        return l10n.categoryCallup;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final color = _categoryColor();
    final timeFormat = DateFormat('dd/MM HH:mm');

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppTheme.darkNavy, AppTheme.mediumBlue],
          ),
        ),
        child: Stack(
          children: [
            // Escudo de fondo
            Positioned(
              right: -20,
              bottom: -20,
              child: Opacity(
                opacity: 0.05,
                child: Image.asset(
                  'assets/images/espanyol_logo.png',
                  height: 120,
                  color: Colors.white,
                  colorBlendMode: BlendMode.srcIn,
                ),
              ),
            ),
            Column(
              children: [
                // Header
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                  child: Row(
                    children: [
                      Icon(_categoryIcon(), color: color, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        _categoryLabel(l10n).toUpperCase(),
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                          letterSpacing: 1.2,
                        ),
                      ),
                      if (notice.targetTeam != 'all') ...[
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            notice.targetTeam,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withValues(alpha: 0.7),
                            ),
                          ),
                        ),
                      ],
                      const Spacer(),
                      Text(
                        timeFormat.format(notice.timestamp),
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.5),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),

                // Body
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        notice.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Body preview
                      Text(
                        notice.body,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 13,
                        ),
                      ),
                      // Confirm button
                      if (notice.requiresConfirmation &&
                          !notice.isConfirmed) ...[
                        const SizedBox(height: 14),
                        Divider(
                            height: 1,
                            color: Colors.white.withValues(alpha: 0.15)),
                        const SizedBox(height: 14),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: onConfirmRead,
                            icon: Icon(Icons.check, size: 18, color: color),
                            label: Text(l10n.confirmRead),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: color,
                              side: BorderSide(
                                  color: color.withValues(alpha: 0.6),
                                  width: 1.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                      // Confirmed indicator
                      if (notice.isConfirmed) ...[
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(
                              Icons.check_circle,
                              size: 16,
                              color: AppTheme.accentGreen,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              l10n.noticeConfirmed,
                              style: const TextStyle(
                                color: AppTheme.accentGreen,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showNoticeDetail(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(notice.title),
        content: SingleChildScrollView(child: Text(notice.body)),
        actions: [
          if (notice.requiresConfirmation && !notice.isConfirmed)
            FilledButton(
              onPressed: () {
                onConfirmRead?.call();
                Navigator.pop(ctx);
              },
              child: Text(l10n.confirmRead),
            ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
        ],
      ),
    );
  }
}
