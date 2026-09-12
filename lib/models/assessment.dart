enum AssessmentStatus { stable, needsAttention, moderate }

class AssessmentQuestion {
  final String id;
  final String question;
  final List<String> options;
  final String category;

  const AssessmentQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.category,
  });
}

class AssessmentResult {
  final String id;
  final DateTime date;
  final int totalScore;
  final int maxScore;
  final AssessmentStatus status;
  final String summary;
  final List<String> contributingPatterns;
  final String recommendedAction;

  const AssessmentResult({
    required this.id,
    required this.date,
    required this.totalScore,
    required this.maxScore,
    required this.status,
    required this.summary,
    required this.contributingPatterns,
    required this.recommendedAction,
  });

  double get scorePercentage => totalScore / maxScore;

  String get statusLabel {
    switch (status) {
      case AssessmentStatus.stable:
        return 'Saat Ini Stabil';
      case AssessmentStatus.moderate:
        return 'Pola Sedang';
      case AssessmentStatus.needsAttention:
        return 'Perlu Perhatian';
    }
  }
}
