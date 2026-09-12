class DailyCheckin {
  final String id;
  final DateTime date;
  final String mood;
  final int moodScore;

  const DailyCheckin({
    required this.id,
    required this.date,
    required this.mood,
    required this.moodScore,
  });
}
