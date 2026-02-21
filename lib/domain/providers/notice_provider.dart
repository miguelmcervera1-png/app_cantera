import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/mock/mock_data.dart';
import '../../data/models/notice_model.dart';

class NoticeNotifier extends StateNotifier<List<NoticeModel>> {
  NoticeNotifier() : super(MockData.notices);

  void addNotice(NoticeModel notice) {
    state = [notice, ...state];
  }

  void confirmRead(String noticeId) {
    state = [
      for (final notice in state)
        if (notice.noticeId == noticeId)
          notice.copyWith(isConfirmed: true)
        else
          notice,
    ];
  }
}

final noticeProvider =
    StateNotifierProvider<NoticeNotifier, List<NoticeModel>>(
  (ref) => NoticeNotifier(),
);

enum NoticeFilter { all, myTeam, admin }

final noticeFilterProvider = StateProvider<NoticeFilter>(
  (ref) => NoticeFilter.all,
);

final filteredNoticesProvider = Provider<List<NoticeModel>>((ref) {
  final notices = ref.watch(noticeProvider);
  final filter = ref.watch(noticeFilterProvider);
  final userTeam = ref.watch(_userTeamProvider);

  switch (filter) {
    case NoticeFilter.all:
      return notices;
    case NoticeFilter.myTeam:
      return notices
          .where((n) => n.targetTeam == userTeam || n.targetTeam == 'all')
          .toList();
    case NoticeFilter.admin:
      return notices
          .where((n) =>
              n.title.toLowerCase().contains('pago') ||
              n.title.toLowerCase().contains('cuota') ||
              n.title.toLowerCase().contains('payment'))
          .toList();
  }
});

// Internal provider to get user team from auth
final _userTeamProvider = Provider<String>((ref) {
  // Import lazily to avoid circular dependency
  return 'Alevín A';
});

final urgentNoticesProvider = Provider<List<NoticeModel>>((ref) {
  final notices = ref.watch(noticeProvider);
  return notices
      .where((n) => n.category == NoticeCategory.urgent && !n.isConfirmed)
      .toList();
});
