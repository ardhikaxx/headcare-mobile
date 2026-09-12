enum PainLocation { forehead, temples, backOfHead, aroundEyes, wholeHead, neck }

enum PainCharacter { throbbing, pressure, sharp, dull, pulsating }

enum HeadacheTrigger {
  lackOfSleep,
  stress,
  dehydration,
  screenTime,
  skippedMeal,
  caffeine,
  exercise,
  weather,
  alcohol,
  strongSmell,
}

enum HeadacheSeverity { mild, moderate, severe }

class HeadacheEpisode {
  final String id;
  final DateTime startTime;
  final DateTime? endTime;
  final int intensity;
  final List<PainLocation> locations;
  final List<PainCharacter> characters;
  final Duration duration;
  final List<String> symptoms;
  final List<HeadacheTrigger> triggers;
  final bool tookMedication;
  final String? medicationName;
  final String? notes;
  final Duration sleepDuration;
  final int waterIntakeGlasses;
  final String? activityBefore;

  const HeadacheEpisode({
    required this.id,
    required this.startTime,
    this.endTime,
    required this.intensity,
    required this.locations,
    required this.characters,
    required this.duration,
    required this.symptoms,
    required this.triggers,
    this.tookMedication = false,
    this.medicationName,
    this.notes,
    this.sleepDuration = const Duration(hours: 7),
    this.waterIntakeGlasses = 8,
    this.activityBefore,
  });

  HeadacheSeverity get severity {
    if (intensity <= 3) return HeadacheSeverity.mild;
    if (intensity <= 6) return HeadacheSeverity.moderate;
    return HeadacheSeverity.severe;
  }

  String get intensityLabel {
    if (intensity <= 3) return 'Ringan';
    if (intensity <= 6) return 'Sedang';
    return 'Berat';
  }

  String get durationFormatted {
    final h = duration.inHours;
    final m = duration.inMinutes % 60;
    if (h > 0) return '${h}j ${m}m';
    return '${m}m';
  }

  String get locationLabel => locations.map((l) {
    switch (l) {
      case PainLocation.forehead: return 'Dahi';
      case PainLocation.temples: return 'Pelipis';
      case PainLocation.backOfHead: return 'Belakang Kepala';
      case PainLocation.aroundEyes: return 'Sekitar Mata';
      case PainLocation.wholeHead: return 'Seluruh Kepala';
      case PainLocation.neck: return 'Leher';
    }
  }).join(', ');

  String get characterLabel => characters.map((c) {
    switch (c) {
      case PainCharacter.throbbing: return 'Berdenyut';
      case PainCharacter.pressure: return 'Tekanan';
      case PainCharacter.sharp: return 'Tajam';
      case PainCharacter.dull: return 'Tumpul';
      case PainCharacter.pulsating: return 'Berdenyut Nadi';
    }
  }).join(', ');

  String get triggerLabel => triggers.map((t) {
    switch (t) {
      case HeadacheTrigger.lackOfSleep: return 'Kurang Tidur';
      case HeadacheTrigger.stress: return 'Stres';
      case HeadacheTrigger.dehydration: return 'Dehidrasi';
      case HeadacheTrigger.screenTime: return 'Waktu Layar';
      case HeadacheTrigger.skippedMeal: return 'Melewatkan Makan';
      case HeadacheTrigger.caffeine: return 'Kafein';
      case HeadacheTrigger.exercise: return 'Olahraga';
      case HeadacheTrigger.weather: return 'Cuaca';
      case HeadacheTrigger.alcohol: return 'Alkohol';
      case HeadacheTrigger.strongSmell: return 'Bau Menyengat';
    }
  }).join(', ');
}
