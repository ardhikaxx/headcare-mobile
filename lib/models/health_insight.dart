enum NotificationType { appointment, monitoring, education, reminder }

enum HealthInsightType { pattern, trigger, lifestyle, comparison }

class AppNotification {
  final String id;
  final String title;
  final String message;
  final DateTime dateTime;
  final NotificationType type;
  final bool isRead;

  const AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.dateTime,
    required this.type,
    this.isRead = false,
  });
}

class HealthInsight {
  final String id;
  final String title;
  final String description;
  final HealthInsightType type;
  final DateTime date;

  const HealthInsight({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.date,
  });
}
