enum NoticeCategory { urgent, informative, callup }

class NoticeModel {
  final String noticeId;
  final NoticeCategory category;
  final String targetTeam;
  final String title;
  final String body;
  final DateTime timestamp;
  final bool requiresConfirmation;
  final bool isConfirmed;

  const NoticeModel({
    required this.noticeId,
    required this.category,
    required this.targetTeam,
    required this.title,
    required this.body,
    required this.timestamp,
    this.requiresConfirmation = false,
    this.isConfirmed = false,
  });

  NoticeModel copyWith({
    String? noticeId,
    NoticeCategory? category,
    String? targetTeam,
    String? title,
    String? body,
    DateTime? timestamp,
    bool? requiresConfirmation,
    bool? isConfirmed,
  }) {
    return NoticeModel(
      noticeId: noticeId ?? this.noticeId,
      category: category ?? this.category,
      targetTeam: targetTeam ?? this.targetTeam,
      title: title ?? this.title,
      body: body ?? this.body,
      timestamp: timestamp ?? this.timestamp,
      requiresConfirmation: requiresConfirmation ?? this.requiresConfirmation,
      isConfirmed: isConfirmed ?? this.isConfirmed,
    );
  }
}
