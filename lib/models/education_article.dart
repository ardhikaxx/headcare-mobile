class EducationArticle {
  final String id;
  final String title;
  final String summary;
  final String content;
  final String category;
  final int readingTimeMinutes;
  final DateTime publishDate;

  const EducationArticle({
    required this.id,
    required this.title,
    required this.summary,
    required this.content,
    required this.category,
    required this.readingTimeMinutes,
    required this.publishDate,
  });
}
