class Doctor {
  final String id;
  final String name;
  final String title;
  final String specialty;
  final int experienceYears;
  final double rating;
  final int reviewCount;
  final double consultationFee;
  final List<String> languages;
  final String bio;
  final List<String> availableSlots;
  final bool isAvailableToday;

  const Doctor({
    required this.id,
    required this.name,
    required this.title,
    required this.specialty,
    required this.experienceYears,
    required this.rating,
    required this.reviewCount,
    required this.consultationFee,
    required this.languages,
    required this.bio,
    required this.availableSlots,
    this.isAvailableToday = true,
  });

  String get specialtyLabel {
    switch (specialty) {
      case 'Neurologist':
        return 'Ahli Saraf';
      default:
        return specialty;
    }
  }
}
