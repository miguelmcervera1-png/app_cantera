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
        return Colors.red;
      case NoticeCategory.informative:
        return AppTheme.primaryBlue;
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
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          _showNoticeDetail(context, l10n);
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(_categoryIcon(), size: 14, color: color),
                        const SizedBox(width: 4),
                        Text(
                          _categoryLabel(l10n),
                          style: TextStyle(
                            color: color,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (notice.targetTeam != 'all') ...[
                    const SizedBox(width: 8),
                    Chip(
                      label: Text(
                        notice.targetTeam,
                        style: const TextStyle(fontSize: 11),
                      ),
                      padding: EdgeInsets.zero,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                  const Spacer(),
                  Text(
                    timeFormat.format(notice.timestamp),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                notice.title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                notice.body,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey[700]),
              ),
              if (notice.requiresConfirmation && !notice.isConfirmed) ...[
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: onConfirmRead,
                    icon: const Icon(Icons.check, size: 18),
                    label: Text(l10n.confirmRead),
                  ),
                ),
              ],
              if (notice.isConfirmed) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 16,
                      color: AppTheme.accentGreen,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      l10n.noticeConfirmed,
                      style: TextStyle(
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
      ),
    );
  }

  void _showNoticeDetail(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
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
