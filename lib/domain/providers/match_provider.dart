import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/mock/mock_data.dart';
import '../../data/models/match_model.dart';

final matchProvider = Provider<List<MatchModel>>((ref) {
  return MockData.matches;
});

final nextMatchProvider = Provider<MatchModel?>((ref) {
  final matches = ref.watch(matchProvider);
  if (matches.isEmpty) return null;
  final now = DateTime.now();
  final upcoming = matches.where((m) => m.date.isAfter(now)).toList()
    ..sort((a, b) => a.date.compareTo(b.date));
  return upcoming.isNotEmpty ? upcoming.first : matches.last;
});
