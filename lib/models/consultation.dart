enum ConsultationType { chat, video }
enum ConsultationStatus { scheduled, ongoing, completed, cancelled }

class Consultation {
  final String id;
  final String doctorId;
  final String doctorName;
  final String doctorSpecialty;
  final DateTime dateTime;
  final ConsultationType type;
  final ConsultationStatus status;
  final String? chiefComplaint;
  final bool shareHeadacheSummary;
  final String? summary;
  final String? doctorRecommendation;
  final DateTime? followUpDate;
  final Duration duration;

  const Consultation({
    required this.id,
    required this.doctorId,
    required this.doctorName,
    required this.doctorSpecialty,
    required this.dateTime,
    required this.type,
    required this.status,
    this.chiefComplaint,
    this.shareHeadacheSummary = false,
    this.summary,
    this.doctorRecommendation,
    this.followUpDate,
    this.duration = const Duration(minutes: 30),
  });

  String get typeLabel {
    switch (type) {
      case ConsultationType.chat:
        return 'Chat';
      case ConsultationType.video:
        return 'Video Call';
    }
  }

  String get statusLabel {
    switch (status) {
      case ConsultationStatus.scheduled:
        return 'Terjadwal';
      case ConsultationStatus.ongoing:
        return 'Berlangsung';
      case ConsultationStatus.completed:
        return 'Selesai';
      case ConsultationStatus.cancelled:
        return 'Dibatalkan';
    }
  }
}
