import 'package:flutter/material.dart';
import 'package:app_cantera/l10n/generated/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/providers/notice_provider.dart';
import '../widgets/notice_card.dart';

class CommunicationsScreen extends ConsumerWidget {
  const CommunicationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final filter = ref.watch(noticeFilterProvider);
    final notices = ref.watch(filteredNoticesProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.navComms),
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: l10n.tabNotices),
              Tab(text: l10n.tabSchedule),
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
                      _FilterChipWidget(
                        label: l10n.filterAll,
                        selected: filter == NoticeFilter.all,
                        onSelected:
                            () =>
                                ref.read(noticeFilterProvider.notifier).state =
                                    NoticeFilter.all,
                      ),
                      const SizedBox(width: 8),
                      _FilterChipWidget(
                        label: l10n.filterMyTeam,
                        selected: filter == NoticeFilter.myTeam,
                        onSelected:
                            () =>
                                ref.read(noticeFilterProvider.notifier).state =
                                    NoticeFilter.myTeam,
                      ),
                      const SizedBox(width: 8),
                      _FilterChipWidget(
                        label: l10n.filterAdmin,
                        selected: filter == NoticeFilter.admin,
                        onSelected:
                            () =>
                                ref.read(noticeFilterProvider.notifier).state =
                                    NoticeFilter.admin,
                      ),
                    ],
                  ),
                ),
                // Notices list
                Expanded(
                  child:
                      notices.isEmpty
                          ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.notifications_off_outlined,
                                  size: 64,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  l10n.noNotices,
                                  style: TextStyle(color: Colors.grey[500]),
                                ),
                              ],
                            ),
                          )
                          : ListView.builder(
                            padding: const EdgeInsets.only(bottom: 16),
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
                                    SnackBar(content: Text(l10n.noticeConfirmed)),
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

class _FilterChipWidget extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onSelected;

  const _FilterChipWidget({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onSelected(),
      showCheckmark: false,
    );
  }
}

class _ScheduleTab extends ConsumerWidget {
  const _ScheduleTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    // Mock schedule data
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
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final item = scheduleItems[index];
        final isMatch = item.type == l10n.match;

        return Card(
          margin: EdgeInsets.zero,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor:
                  isMatch ? Colors.orange.shade100 : Colors.blue.shade50,
              child: Icon(
                isMatch ? Icons.sports_soccer : Icons.fitness_center,
                color: isMatch ? Colors.orange : Colors.blue,
              ),
            ),
            title: Text(
              item.day,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text('${item.time} · ${item.location}'),
            trailing: Chip(
              label: Text(
                item.type,
                style: const TextStyle(fontSize: 11),
              ),
              visualDensity: VisualDensity.compact,
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
