class MatchModel {
  final String matchId;
  final String rival;
  final DateTime date;
  final String location;
  final String category;

  const MatchModel({
    required this.matchId,
    required this.rival,
    required this.date,
    required this.location,
    required this.category,
  });
}
