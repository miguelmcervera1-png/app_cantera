import 'package:flutter/material.dart';
import 'package:app_cantera/l10n/generated/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../domain/providers/auth_provider.dart';
import '../../domain/providers/notice_provider.dart';
import '../widgets/notice_card.dart';

class CommunicationsScreen extends ConsumerWidget {
  const CommunicationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final filter = ref.watch(noticeFilterProvider);
    final notices = ref.watch(filteredNoticesProvider);
    final auth = ref.watch(authProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/espanyol_logo.png',
                height: 32,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(l10n.navComms, style: const TextStyle(fontSize: 16)),
                  Text(
                    auth.userTeam,
                    style: TextStyle(
                      fontSize: 11,
                      color: AppTheme.accentGold,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
            indicatorColor: AppTheme.accentGold,
            indicatorWeight: 3,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(text: l10n.tabNotices.toUpperCase()),
              Tab(text: l10n.tabSchedule.toUpperCase()),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab 1: Official Notices
            Column(
              children: [
                // Filter chips
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                  child: Row(
                    children: [
                      FilterChip(
                        label: Text(l10n.filterAll),
                        selected: filter == NoticeFilter.all,
                        onSelected: (_) =>
                            ref.read(noticeFilterProvider.notifier).state =
                                NoticeFilter.all,
                        showCheckmark: false,
                        selectedColor: AppTheme.primaryBlue,
                        labelStyle: TextStyle(
                          color: filter == NoticeFilter.all
                              ? Colors.white
                              : AppTheme.textSecondary,
                          fontWeight: filter == NoticeFilter.all
                              ? FontWeight.w600
                              : FontWeight.w400,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: Text(l10n.filterMyTeam),
                        selected: filter == NoticeFilter.myTeam,
                        onSelected: (_) =>
                            ref.read(noticeFilterProvider.notifier).state =
                                NoticeFilter.myTeam,
                        showCheckmark: false,
                        selectedColor: AppTheme.primaryBlue,
                        labelStyle: TextStyle(
                          color: filter == NoticeFilter.myTeam
                              ? Colors.white
                              : AppTheme.textSecondary,
                          fontWeight: filter == NoticeFilter.myTeam
                              ? FontWeight.w600
                              : FontWeight.w400,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: Text(l10n.filterAdmin),
                        selected: filter == NoticeFilter.admin,
                        onSelected: (_) =>
                            ref.read(noticeFilterProvider.notifier).state =
                                NoticeFilter.admin,
                        showCheckmark: false,
                        selectedColor: AppTheme.primaryBlue,
                        labelStyle: TextStyle(
                          color: filter == NoticeFilter.admin
                              ? Colors.white
                              : AppTheme.textSecondary,
                          fontWeight: filter == NoticeFilter.admin
                              ? FontWeight.w600
                              : FontWeight.w400,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                // Notices list
                Expanded(
                  child: notices.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                radius: 44,
                                backgroundColor: AppTheme.surfaceLight,
                                child: Icon(
                                  Icons.notifications_off_outlined,
                                  size: 48,
                                  color: AppTheme.primaryBlue
                                      .withValues(alpha: 0.3),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                l10n.noNotices,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: AppTheme.textSecondary,
                                    ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding:
                              const EdgeInsets.only(top: 8, bottom: 16),
                          itemCount: notices.length,
                          itemBuilder: (context, index) {
                            final notice = notices[index];
                            return NoticeCard(
                              notice: notice,
                              onConfirmRead: () {
                                ref
                                    .read(noticeProvider.notifier)
                                    .confirmRead(notice.noticeId);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text(l10n.noticeConfirmed)),
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            ),

            // Tab 2: My Schedule
            const _ScheduleTab(),
          ],
        ),
      ),
    );
  }
}

class _ScheduleTab extends ConsumerWidget {
  const _ScheduleTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final scheduleItems = [
      _ScheduleItem(
        day: 'Lunes / Monday',
        time: '17:30 - 19:00',
        type: l10n.training,
        location: 'Campo 2',
      ),
      _ScheduleItem(
        day: 'Miércoles / Wednesday',
        time: '17:30 - 19:00',
        type: l10n.training,
        location: 'Campo 2',
      ),
      _ScheduleItem(
        day: 'Viernes / Friday',
        time: '17:00 - 18:30',
        type: l10n.training,
        location: 'Campo 1',
      ),
      _ScheduleItem(
        day: 'Sábado / Saturday',
        time: '10:00',
        type: l10n.match,
        location: 'Ciutat Esportiva',
      ),
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: scheduleItems.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final item = scheduleItems[index];
        final isMatch = item.type == l10n.match;
        final itemColor = isMatch ? Colors.orange : AppTheme.primaryBlue;

        return Card(
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.zero,
          child: IntrinsicHeight(
            child: Row(
              children: [
                // Left accent strip
                Container(
                  width: 5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: isMatch
                          ? [Colors.orange, Colors.orange.shade300]
                          : [AppTheme.primaryBlue, AppTheme.lightBlue],
                    ),
                  ),
                ),
                // Icon
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: itemColor.withValues(alpha: 0.1),
                    child: Icon(
                      isMatch ? Icons.sports_soccer : Icons.fitness_center,
                      color: itemColor,
                    ),
                  ),
                ),
                // Text content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item.day,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${item.time} \u00B7 ${item.location}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Type badge
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Chip(
                    label: Text(
                      item.type.toUpperCase(),
                      style: TextStyle(
                        color: itemColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        letterSpacing: 0.8,
                      ),
                    ),
                    backgroundColor: itemColor.withValues(alpha: 0.1),
                    side: BorderSide.none,
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ScheduleItem {
  final String day;
  final String time;
  final String type;
  final String location;

  _ScheduleItem({
    required this.day,
    required this.time,
    required this.type,
    required this.location,
  });
}
