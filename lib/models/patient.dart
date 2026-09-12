class Patient {
  final String id;
  final String name;
  final DateTime dateOfBirth;
  final String gender;
  final String bloodType;
  final double weight;
  final double height;
  final String phone;
  final String email;
  final String emergencyContact;
  final String emergencyPhone;
  final List<String> allergies;
  final List<String> currentMedications;
  final String preferredConsultationType;

  const Patient({
    required this.id,
    required this.name,
    required this.dateOfBirth,
    required this.gender,
    required this.bloodType,
    required this.weight,
    required this.height,
    required this.phone,
    required this.email,
    required this.emergencyContact,
    required this.emergencyPhone,
    this.allergies = const [],
    this.currentMedications = const [],
    this.preferredConsultationType = 'Video',
  });

  int get age {
    final now = DateTime(2026, 9, 11);
    int years = now.year - dateOfBirth.year;
    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      years--;
    }
    return years;
  }

  String get initials {
    final parts = name.split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}';
    return name[0];
  }
}
