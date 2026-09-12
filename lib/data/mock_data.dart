import '../models/models.dart';

class MockData {
  MockData._();

  static final patient = Patient(
    id: 'P001',
    name: 'Yanuar Ardhika',
    dateOfBirth: DateTime(2005, 5, 14),
    gender: 'Laki-laki',
    bloodType: 'O',
    weight: 62,
    height: 170,
    phone: '+62 812-3456-7890',
    email: 'yanuar.ardhika@email.com',
    emergencyContact: 'Siti Ardhika (Mother)',
    emergencyPhone: '+62 812-9876-5432',
    allergies: ['Tidak ada yang diketahui'],
    currentMedications: ['Ibuprofen 400mg (saat diperlukan)'],
    preferredConsultationType: 'Video',
  );

  static final List<HeadacheEpisode> headacheEpisodes = [
    HeadacheEpisode(
      id: 'EP001',
      startTime: DateTime(2026, 9, 10, 14, 30),
      endTime: DateTime(2026, 9, 10, 17, 0),
      intensity: 6,
      locations: [PainLocation.temples, PainLocation.forehead],
      characters: [PainCharacter.throbbing],
      duration: const Duration(hours: 2, minutes: 30),
      symptoms: ['Sensitivitas terhadap cahaya', 'Mual'],
      triggers: [HeadacheTrigger.screenTime, HeadacheTrigger.lackOfSleep],
      tookMedication: true,
      medicationName: 'Ibuprofen 400mg',
      sleepDuration: const Duration(hours: 5),
      waterIntakeGlasses: 5,
      activityBefore: 'Belajar untuk ujian menggunakan laptop',
    ),
    HeadacheEpisode(
      id: 'EP002',
      startTime: DateTime(2026, 9, 8, 11, 0),
      endTime: DateTime(2026, 9, 8, 12, 45),
      intensity: 4,
      locations: [PainLocation.forehead],
      characters: [PainCharacter.pressure],
      duration: const Duration(hours: 1, minutes: 45),
      symptoms: ['Pusing ringan'],
      triggers: [HeadacheTrigger.dehydration, HeadacheTrigger.skippedMeal],
      tookMedication: false,
      sleepDuration: const Duration(hours: 7),
      waterIntakeGlasses: 3,
      activityBefore: 'Kelas pagi',
    ),
    HeadacheEpisode(
      id: 'EP003',
      startTime: DateTime(2026, 9, 6, 16, 0),
      endTime: DateTime(2026, 9, 6, 19, 30),
      intensity: 7,
      locations: [PainLocation.backOfHead, PainLocation.neck],
      characters: [PainCharacter.throbbing, PainCharacter.pressure],
      duration: const Duration(hours: 3, minutes: 30),
      symptoms: ['Sensitivitas terhadap cahaya', 'Sensitivitas terhadap suara', 'Mual'],
      triggers: [
        HeadacheTrigger.stress,
        HeadacheTrigger.lackOfSleep,
        HeadacheTrigger.screenTime,
      ],
      tookMedication: true,
      medicationName: 'Ibuprofen 400mg',
      notes: 'Episode sangat intens, harus berbaring di ruangan gelap',
      sleepDuration: const Duration(hours: 4),
      waterIntakeGlasses: 4,
      activityBefore: 'Batas waktu pengumpulan, stres tinggi',
    ),
    HeadacheEpisode(
      id: 'EP004',
      startTime: DateTime(2026, 9, 5, 9, 0),
      endTime: DateTime(2026, 9, 5, 10, 30),
      intensity: 3,
      locations: [PainLocation.temples],
      characters: [PainCharacter.dull],
      duration: const Duration(hours: 1, minutes: 30),
      symptoms: [],
      triggers: [HeadacheTrigger.lackOfSleep],
      tookMedication: false,
      sleepDuration: const Duration(hours: 5, minutes: 30),
      waterIntakeGlasses: 6,
      activityBefore: 'Bangun pagi untuk kelas',
    ),
    HeadacheEpisode(
      id: 'EP005',
      startTime: DateTime(2026, 9, 3, 20, 0),
      endTime: DateTime(2026, 9, 3, 22, 15),
      intensity: 5,
      locations: [PainLocation.forehead, PainLocation.aroundEyes],
      characters: [PainCharacter.pressure],
      duration: const Duration(hours: 2, minutes: 15),
      symptoms: ['Penglihatan kabur', 'Kelelahan mata'],
      triggers: [HeadacheTrigger.screenTime],
      tookMedication: false,
      sleepDuration: const Duration(hours: 7),
      waterIntakeGlasses: 6,
      activityBefore: 'Menggunakan ponsel dalam waktu lama',
    ),
    HeadacheEpisode(
      id: 'EP006',
      startTime: DateTime(2026, 9, 1, 13, 0),
      endTime: DateTime(2026, 9, 1, 15, 0),
      intensity: 5,
      locations: [PainLocation.temples],
      characters: [PainCharacter.pulsating],
      duration: const Duration(hours: 2),
      symptoms: ['Mual ringan'],
      triggers: [HeadacheTrigger.skippedMeal, HeadacheTrigger.dehydration],
      tookMedication: true,
      medicationName: 'Paracetamol 500mg',
      sleepDuration: const Duration(hours: 7),
      waterIntakeGlasses: 4,
      activityBefore: 'Melewatkan makan siang saat jadwal sibuk',
    ),
    HeadacheEpisode(
      id: 'EP007',
      startTime: DateTime(2026, 8, 29, 17, 30),
      endTime: DateTime(2026, 8, 29, 21, 0),
      intensity: 8,
      locations: [
        PainLocation.wholeHead,
        PainLocation.neck,
      ],
      characters: [PainCharacter.throbbing],
      duration: const Duration(hours: 3, minutes: 30),
      symptoms: [
        'Mual',
        'Sensitivitas terhadap cahaya',
        'Sensitivitas terhadap suara',
        'Pusing',
      ],
      triggers: [
        HeadacheTrigger.stress,
        HeadacheTrigger.dehydration,
      ],
      tookMedication: true,
      medicationName: 'Ibuprofen 400mg',
      notes: 'Episode terburuk bulan ini. Harus membatalkan rencana malam.',
      sleepDuration: const Duration(hours: 4, minutes: 30),
      waterIntakeGlasses: 3,
      activityBefore: 'Sesi belajar panjang, lupa minum air',
    ),
    HeadacheEpisode(
      id: 'EP008',
      startTime: DateTime(2026, 8, 27, 10, 0),
      endTime: DateTime(2026, 8, 27, 11, 30),
      intensity: 3,
      locations: [PainLocation.forehead],
      characters: [PainCharacter.dull],
      duration: const Duration(hours: 1, minutes: 30),
      symptoms: [],
      triggers: [HeadacheTrigger.weather],
      tookMedication: false,
      sleepDuration: const Duration(hours: 8),
      waterIntakeGlasses: 7,
      activityBefore: 'Rutinitas pagi biasa',
    ),
    HeadacheEpisode(
      id: 'EP009',
      startTime: DateTime(2026, 8, 25, 15, 0),
      endTime: DateTime(2026, 8, 25, 17, 30),
      intensity: 6,
      locations: [PainLocation.temples, PainLocation.backOfHead],
      characters: [PainCharacter.pressure, PainCharacter.sharp],
      duration: const Duration(hours: 2, minutes: 30),
      symptoms: ['Sensitivitas terhadap cahaya', 'Kekakuan leher'],
      triggers: [HeadacheTrigger.stress, HeadacheTrigger.screenTime],
      tookMedication: true,
      medicationName: 'Ibuprofen 400mg',
      sleepDuration: const Duration(hours: 6),
      waterIntakeGlasses: 5,
      activityBefore: 'Meeting online berturut-turut',
    ),
    HeadacheEpisode(
      id: 'EP010',
      startTime: DateTime(2026, 8, 22, 21, 0),
      endTime: DateTime(2026, 8, 22, 22, 30),
      intensity: 4,
      locations: [PainLocation.forehead],
      characters: [PainCharacter.dull],
      duration: const Duration(hours: 1, minutes: 30),
      symptoms: ['Pusing ringan'],
      triggers: [HeadacheTrigger.exercise],
      tookMedication: false,
      sleepDuration: const Duration(hours: 7),
      waterIntakeGlasses: 8,
      activityBefore: 'Sesi olahraga intens',
    ),
    HeadacheEpisode(
      id: 'EP011',
      startTime: DateTime(2026, 8, 19, 14, 0),
      endTime: DateTime(2026, 8, 19, 16, 0),
      intensity: 5,
      locations: [PainLocation.temples],
      characters: [PainCharacter.throbbing],
      duration: const Duration(hours: 2),
      symptoms: ['Mual'],
      triggers: [HeadacheTrigger.lackOfSleep, HeadacheTrigger.caffeine],
      tookMedication: true,
      medicationName: 'Paracetamol 500mg',
      sleepDuration: const Duration(hours: 5),
      waterIntakeGlasses: 5,
      activityBefore: 'Minum kopi terlalu banyak setelah tidur tidak nyenyak',
    ),
    HeadacheEpisode(
      id: 'EP012',
      startTime: DateTime(2026, 8, 16, 11, 30),
      endTime: DateTime(2026, 8, 16, 12, 30),
      intensity: 3,
      locations: [PainLocation.forehead],
      characters: [PainCharacter.dull],
      duration: const Duration(hours: 1),
      symptoms: [],
      triggers: [HeadacheTrigger.dehydration],
      tookMedication: false,
      sleepDuration: const Duration(hours: 7),
      waterIntakeGlasses: 2,
      activityBefore: 'Lupa minum air selama aktivitas pagi',
    ),
    HeadacheEpisode(
      id: 'EP013',
      startTime: DateTime(2026, 8, 13, 16, 30),
      endTime: DateTime(2026, 8, 13, 18, 30),
      intensity: 6,
      locations: [PainLocation.aroundEyes, PainLocation.forehead],
      characters: [PainCharacter.pressure],
      duration: const Duration(hours: 2),
      symptoms: ['Penglihatan kabur', 'Sensitivitas terhadap cahaya', 'Kelelahan mata'],
      triggers: [HeadacheTrigger.screenTime, HeadacheTrigger.lackOfSleep],
      tookMedication: true,
      medicationName: 'Ibuprofen 400mg',
      sleepDuration: const Duration(hours: 5, minutes: 30),
      waterIntakeGlasses: 5,
      activityBefore: 'Hari panjang bekerja dengan layar',
    ),
  ];

  static final List<AssessmentResult> assessmentResults = [
    AssessmentResult(
      id: 'AR001',
      date: DateTime(2026, 9, 9),
      totalScore: 14,
      maxScore: 30,
      status: AssessmentStatus.needsAttention,
      summary:
          'Catatan sakit kepala Anda baru-baru ini menunjukkan bahwa gejala Anda semakin sering mempengaruhi aktivitas sehari-hari. Pertimbangkan untuk mendiskusikan pola ini dengan tenaga kesehatan profesional.',
      contributingPatterns: [
        'Episode sering terjadi dengan intensitas tinggi (6-8/10)',
        'Beberapa pemicu sering tumpang tindih, terutama kurang tidur dan paparan layar',
        'Episode sering disertai mual dan sensitivitas terhadap cahaya',
        'Penggunaan obat meningkat dalam 2 minggu terakhir',
      ],
      recommendedAction:
          'Diskusikan dengan tenaga kesehatan profesional untuk mengeksplorasi strategi pengelolaan dan menyingkirkan penyebab yang mendasari.',
    ),
    AssessmentResult(
      id: 'AR002',
      date: DateTime(2026, 8, 26),
      totalScore: 10,
      maxScore: 30,
      status: AssessmentStatus.moderate,
      summary:
          'Pola sakit kepala Anda menunjukkan frekuensi sedang dengan pemicu yang dapat diidentifikasi. Penyesuaian gaya hidup dapat membantu mengurangi frekuensi episode.',
      contributingPatterns: [
        'Sakit kepala tampak berkorelasi dengan pola tidur yang tidak teratur',
        'Episode sore hari paling sering terjadi',
        'Pemicu terkait stres tercatat dalam beberapa episode',
      ],
      recommendedAction:
          'Fokus pada kebersihan tidur dan pengelolaan stres. Lanjutkan pemantauan dan lakukan penilaian ulang dalam 2 minggu.',
    ),
  ];

  static final List<Doctor> doctors = [
    Doctor(
      id: 'D001',
      name: 'dr. Nadia Pratama',
      title: 'Sp.N',
      specialty: 'Neurolog',
      experienceYears: 12,
      rating: 4.8,
      reviewCount: 256,
      consultationFee: 150000,
      languages: ['Indonesia', 'Inggris'],
      bio:
          'Dr. Nadia adalah spesialis neurolog dengan pengalaman lebih dari 12 tahun dalam pengelolaan sakit kepala dan migrain. Beliau bersemangat untuk membantu pasien memahami pola sakit kepala mereka dan menemukan strategi pengelolaan yang efektif.',
      availableSlots: [
        'Hari ini 20:00',
        'Besok 09:30',
        'Besok 13:00',
        'Besok 19:30',
      ],
      isAvailableToday: true,
    ),
    Doctor(
      id: 'D002',
      name: 'dr. Raka Wijaya',
      title: 'Sp.S',
      specialty: 'Neurolog',
      experienceYears: 8,
      rating: 4.6,
      reviewCount: 178,
      consultationFee: 125000,
      languages: ['Indonesia', 'Inggris', 'Jawa'],
      bio:
          'Dr. Raka mengkhususkan diri dalam gangguan neurologis dengan fokus pada gangguan sakit kepala. Beliau mengambil pendekatan holistik dalam perawatan pasien, mempertimbangkan faktor gaya hidup bersamaan dengan pengobatan medis.',
      availableSlots: [
        'Besok 10:00',
        'Besok 14:00',
        'Besok 18:00',
      ],
      isAvailableToday: false,
    ),
    Doctor(
      id: 'D003',
      name: 'dr. Alya Permata',
      title: 'Sp.N',
      specialty: 'Neurolog',
      experienceYears: 15,
      rating: 4.9,
      reviewCount: 312,
      consultationFee: 175000,
      languages: ['Indonesia', 'Inggris'],
      bio:
          'Dr. Alya adalah seorang neurolog berpengalaman tinggi dengan keahlian dalam bidang kedokteran sakit kepala dan pengelolaan nyeri. Beliau dikenal dengan pendekatannya yang menyeluruh dan komunikasi pasien yang sangat baik.',
      availableSlots: [
        'Hari ini 21:00',
        'Besok 08:00',
        'Besok 11:00',
        'Besok 16:00',
      ],
      isAvailableToday: true,
    ),
  ];

  static final List<Consultation> consultationHistory = [
    Consultation(
      id: 'C001',
      doctorId: 'D001',
      doctorName: 'dr. Nadia Pratama, Sp.N',
      doctorSpecialty: 'Neurolog',
      dateTime: DateTime(2026, 8, 22, 19, 30),
      type: ConsultationType.video,
      status: ConsultationStatus.completed,
      chiefComplaint: 'Episode sakit kepala berulang dengan frekuensi meningkat',
      shareHeadacheSummary: true,
      summary:
          'Mendiskusikan pola sakit kepala berulang selama sebulan terakhir. Meninjau entri diary sakit kepala dan mengidentifikasi pemicu potensial. Dr. Nadia merekomendasikan untuk melanjutkan diary sakit kepala dan fokus pada kebersihan tidur.',
      doctorRecommendation:
          'Pertahankan jadwal tidur yang konsisten, minum air yang cukup, dan lanjutkan diary sakit kepala. Lakukan kunjungan ulang dalam 2 minggu jika pola berlanjut.',
      followUpDate: DateTime(2026, 9, 5),
      duration: const Duration(minutes: 30),
    ),
    Consultation(
      id: 'C002',
      doctorId: 'D003',
      doctorName: 'dr. Alya Permata, Sp.N',
      doctorSpecialty: 'Neurolog',
      dateTime: DateTime(2026, 8, 5, 14, 0),
      type: ConsultationType.chat,
      status: ConsultationStatus.completed,
      chiefComplaint: 'Pola sakit kepala tipe tensi',
      shareHeadacheSummary: true,
      summary:
          'Mengevaluasi pola sakit kepala tipe tensi. Dr. Alya menilai episode tersebut kemungkinan merupakan sakit kepala tipe tensi dengan beberapa ciri migrain. Merekomendasikan modifikasi gaya hidup.',
      doctorRecommendation:
        'Kurangi paparan layar pada malam hari, praktikkan teknik relaksasi, dan pertahankan jadwal makan yang teratur.',
      followUpDate: DateTime(2026, 8, 19),
      duration: const Duration(minutes: 25),
    ),
    Consultation(
      id: 'C003',
      doctorId: 'D001',
      doctorName: 'dr. Nadia Pratama, Sp.N',
      doctorSpecialty: 'Neurolog',
      dateTime: DateTime(2026, 7, 14, 10, 0),
      type: ConsultationType.video,
      status: ConsultationStatus.completed,
      chiefComplaint: 'Konsultasi awal pemantauan sakit kepala',
      shareHeadacheSummary: false,
      summary:
          'Konsultasi pertama untuk menetapkan baseline pemantauan sakit kepala. Dr. Nadia memberikan panduan tentang cara melacak gejala dan pemicu secara efektif.',
      doctorRecommendation:
          'Mulai diary sakit kepala harian, catat pemicu, tidur, hidrasi, dan tingkat aktivitas. Kembali untuk kunjungan ulang dalam satu bulan.',
      followUpDate: DateTime(2026, 8, 5),
      duration: const Duration(minutes: 30),
    ),
  ];

  static final List<EducationArticle> educationArticles = [
    EducationArticle(
      id: 'EA001',
      title: 'Memahami Pemicu Sakit Kepala yang Umum',
      summary:
          'Pelajari faktor-faktor paling umum yang dapat memicu sakit kepala dan cara mengidentifikasi pemicu pribadi Anda.',
      category: 'Dasar Sakit Kepala',
      readingTimeMinutes: 6,
      publishDate: DateTime(2026, 8, 1),
      content: '''Sakit kepala dapat dipicu oleh berbagai macam faktor, dan memahami pemicu pribadi Anda adalah salah satu langkah terpenting dalam mengelolanya secara efektif.

Pemicu umum meliputi:

**Perubahan Tidur**
Baik kurang tidur maupun tidur berlebihan dapat memicu sakit kepala. Mempertahankan jadwal tidur yang konsisten adalah salah satu langkah pencegahan paling efektif.

**Stres**
Stres emosional adalah salah satu pemicu yang paling sering dilaporkan. Stres dapat menyebabkan ketegangan otot di leher dan kulit kepala, yang mengarah ke sakit kepala tipe tensi.

**Dehidrasi**
Tidak minum air yang cukup sepanjang hari adalah pemicu yang sering terlewatkan. Usahakan minimal 8 gelas air setiap hari.

**Faktor Diet**
Melewatkan makan, makanan dan minuman tertentu (seperti keju yang sudah tua, daging olahan, dan kafein), serta alkohol semuanya dapat berkontribusi terhadap sakit kepala.

**Faktor Lingkungan**
Cahaya terang, suara bising, bau menyengat, dan perubahan cuaca dapat memicu sakit kepala pada individu yang rentan.

**Paparan Layar**
Paparan layar digital dalam waktu lama dapat menyebabkan ketegangan mata dan sakit kepala. Ikuti aturan 20-20-20: setiap 20 menit, lihat sesuatu yang berjarak 6 meter selama 20 detik.

**Perubahan Hormon**
Fluktuasi kadar estrogen dapat memicu sakit kepala pada beberapa individu, terutama sekitar masa menstruasi.

Cara terbaik untuk mengidentifikasi pemicu Anda adalah dengan membuat diary sakit kepala yang detail. Catat kapan sakit kepala Anda terjadi, apa yang Anda lakukan, makan, dan bagaimana perasaan Anda. Seiring waktu, pola-pola akan muncul yang dapat membantu Anda menghindari atau meminimalkan paparan pemicu.

Ingat, mengidentifikasi pemicu tidak berarti Anda dapat mencegah semua sakit kepala, tetapi dapat secara signifikan mengurangi frekuensi dan tingkat keparahannya.''',
    ),
    EducationArticle(
      id: 'EA002',
      title: 'Bagaimana Tidur Memengaruhi Pola Sakit Kepala',
      summary:
          'Hubungan antara kualitas tidur dan sakit kepala sudah terbukti. Temukan bagaimana kebiasaan tidur yang lebih baik dapat membantu.',
      category: 'Tidur',
      readingTimeMinutes: 5,
      publishDate: DateTime(2026, 8, 5),
      content: '''Tidur dan sakit kepala memiliki hubungan yang kompleks dan dua arah. Tidur yang buruk dapat memicu sakit kepala, dan sakit kepala dapat mengganggu tidur. Memutus siklus ini sangat penting untuk pengelolaan yang efektif.

**Bagaimana Kurang Tidur Memicu Sakit Kepala**
Ketika Anda tidak mendapatkan tidur yang cukup, tubuh Anda memproduksi lebih banyak zat kimia yang sensitif terhadap nyeri. Selain itu, kurang tidur dapat memengaruhi kadar serotonin, yang berperan dalam pengaturan sakit kepala.

**Durasi Tidur Ideal**
Kebanyakan orang dewasa membutuhkan 7-9 jam tidur berkualitas setiap malam. Tidur kurang dari 6 jam secara konsisten telah dikaitkan dengan peningkatan frekuensi sakit kepala.

**Tips Kebersihan Tidur**
- Tidur dan bangun pada waktu yang sama setiap hari, bahkan di akhir pekan
- Buat rutinitas menjelang tidur yang menenangkan
- Jaga kamar tidur tetap sejuk, gelap, dan tenang
- Hindari layar setidaknya 30 menit sebelum tidur
- Batasi asupan kafein setelah pukul 14:00
- Hindari makanan berat menjelang tidur

**Kualitas vs Kuantitas Tidur**
Bukan hanya tentang berapa lama Anda tidur, tetapi seberapa baik kualitasnya. Tidur yang terfragmentasi atau sering terbangun bisa sama bermasalahnya dengan tidur yang tidak cukup.

**Kapan Harus Mencari Bantuan**
Jika Anda secara konsisten mengalami kesulitan tidur meskipun sudah memiliki kebersihan tidur yang baik, pertimbangkan untuk mendiskusikannya dengan tenaga kesehatan profesional. Gangguan tidur seperti sleep apnea dapat berkontribusi terhadap sakit kepala kronis.''',
    ),
    EducationArticle(
      id: 'EA003',
      title: 'Hidrasi dan Pengelolaan Sakit Kepala',
      summary:
          'Dehidrasi adalah salah satu pemicu sakit kepala yang paling umum dan dapat dicegah. Pelajari bagaimana menjaga hidrasi dapat membantu.',
      category: 'Hidrasi',
      readingTimeMinutes: 4,
      publishDate: DateTime(2026, 8, 8),
      content: '''Dehidrasi adalah salah satu pemicu sakit kepala yang paling sering dilaporkan, dan untungnya, ini adalah salah satu yang paling mudah diatasi.

**Mengapa Dehidrasi Menyebabkan Sakit Kepala**
Ketika tubuh Anda kehilangan lebih banyak cairan daripada yang masuk, otak Anda dapat berkontraksi sementara akibat kehilangan cairan. Kontraksi ini menarik diri dari tengkorak, menyebabkan nyeri. Selain itu, dehidrasi dapat mengurangi aliran darah dan oksigen ke otak.

**Berapa Banyak Air yang Anda Butuhkan?**
Pedoman umum adalah minum setidaknya 8 gelas (sekitar 2 liter) air setiap hari. Namun, kebutuhan individu bervariasi berdasarkan tingkat aktivitas, iklim, dan ukuran tubuh. Indikator yang baik adalah warna urin - kuning pucat biasanya berarti hidrasi yang cukup.

**Tanda-tanda Dehidrasi Ringan**
- Haus
- Urin berwarna kuning gelap
- Mulut kering
- Kelelahan
- Sakit kepala

**Tips untuk Tetap Terhidrasi**
- Bawa botol air yang dapat digunakan kembali sepanjang hari
- Atur pengingat untuk minum air secara teratur
- Makan makanan yang banyak mengandung air seperti buah dan sayuran
- Minum segelas air pertama kali di pagi hari
- Lacak asupan air harian Anda

**Memantau Hidrasi Anda**
Catat sederhana berapa banyak gelas air yang Anda minum setiap hari. Jika Anda memperhatikan sakit kepala berkorelasi dengan asupan air yang rendah, ini adalah indikator kuat bahwa dehidrasi mungkin menjadi pemicu bagi Anda.''',
    ),
    EducationArticle(
      id: 'EA004',
      title: 'Mengelola Paparan Layar untuk Mengurangi Sakit Kepala',
      summary:
          'Kelelahan mata digital akibat penggunaan layar yang berkepanjangan adalah pemicu sakit kepala utama di dunia modern.',
      category: 'Gaya Hidup',
      readingTimeMinutes: 5,
      publishDate: DateTime(2026, 8, 12),
      content: '''Di dunia digital saat ini, paparan layar adalah bagian yang tidak terhindarkan dari kehidupan sehari-hari. Namun, paparan layar yang berkepanjangan merupakan pemicu sakit kepala yang signifikan bagi banyak orang.

**Apa Itu Kelelahan Mata Digital?**
Kelelahan mata digital (juga disebut sindrom penglihatan komputer) terjadi ketika mata Anda fokus pada layar dalam waktu lama tanpa istirahat yang memadai. Gejalanya meliputi sakit kepala, kelelahan mata, penglihatan kabur, dan mata kering.

**Aturan 20-20-20**
Teknik sederhana ini dapat secara signifikan mengurangi kelelahan mata:
- Setiap 20 menit
- Lihat sesuatu yang berjarak 6 meter
- Selama setidaknya 20 detik

**Pengaturan Ergonomis**
- Posisikan layar Anda setidaknya satu lengan jauhnya
- Bagian atas layar harus berada di atau sedikit di bawah level mata
- Kurangi pantulan layar dengan menyesuaikan pencahayaan atau menggunakan filter layar
- Gunakan ukuran font yang nyaman bagi Anda
- Pertahankan postur yang baik untuk mengurangi ketegangan leher dan bahu

**Pengaturan Layar**
- Sesuaikan kecerahan dengan lingkungan sekitar Anda
- Gunakan mode malam atau filter cahaya biru di malam hari
- Perbesar ukuran teks jika Anda sering membungkuk ke depan
- Pertimbangkan menggunakan mode gelap jika lebih nyaman untuk mata Anda

**Istirahat**
Selain aturan 20-20-20, ambil istirahat lebih lama setiap 1-2 jam. Berdiri, peregangan, dan berjalan selama beberapa menit. Ini membantu mengurangi ketegangan mata dan otot yang dapat berkontribusi terhadap sakit kepala.''',
    ),
    EducationArticle(
      id: 'EA005',
      title: 'Kapan Anda Harus Berbicara dengan Dokter?',
      summary:
          'Kenali tanda-tanda yang menunjukkan sudah waktunya mencari saran medis profesional tentang sakit kepala Anda.',
      category: 'Kunjungi Dokter',
      readingTimeMinutes: 5,
      publishDate: DateTime(2026, 8, 15),
      content: '''Meskipun banyak sakit kepala dapat ditangani dengan perubahan gaya hidup dan obat-obatan yang dijual bebas, ada situasi di mana saran medis profesional sangat penting.

**Kapan Harus ke Dokter**
- Sakit kepala menjadi lebih sering atau parah seiring waktu
- Obat-obatan yang dijual bebas tidak lagi efektif
- Sakit kepala mengganggu aktivitas sehari-hari Anda secara teratur
- Anda perlu mengonsumsi obat pereda nyeri lebih dari dua kali seminggu
- Sakit kepala menyebabkan kesusahan atau kecemasan yang signifikan

**Segera Dapatkan Pertolongan Medis Jika:**
- Anda mengalami sakit kepala terburuk dalam hidup Anda (sakit kepala petir)
- Sakit kepala muncul tiba-tiba dan sangat parah
- Sakit kepala terjadi setelah cedera kepala
- Sakit kepala disertai demam, leher kaku, kebingungan, atau kejang
- Anda mengalami kelemahan, mati rasa, atau kesulitan berbicara
- Sakit kepala disertai perubahan penglihatan atau kehilangan kesadaran

**Mempersiapkan Janji Temu Anda**
Untuk memanfaatkan konsultasi Anda sebaik mungkin:
- Bawa diary sakit kepala atau catatan aplikasi Anda
- Catat pola-pola yang telah Anda identifikasi
- Daftar semua obat yang sedang Anda konsumsi
- Jelaskan gejala Anda secara detail
- Ajukan pertanyaan tentang hal-hal yang tidak Anda pahami

**Yang Perlu Diharapkan**
Dokter Anda kemungkinan akan menanyakan riwayat sakit kepala Anda, melakukan pemeriksaan fisik, dan mungkin memesan tes jika diperlukan. Mereka akan bekerja sama dengan Anda untuk membuat rencana pengelolaan yang disesuaikan dengan situasi spesifik Anda.

Ingat, mencari saran medis tidak berarti sakit kepala Anda serius - itu berarti Anda mengambil pendekatan proaktif terhadap kesehatan Anda.''',
    ),
    EducationArticle(
      id: 'EA006',
      title: 'Membuat Diary Sakit Kepala',
      summary:
          'Diary sakit kepala adalah salah satu alat paling ampuh untuk memahami dan mengelola sakit kepala Anda secara efektif.',
      category: 'Dasar Sakit Kepala',
      readingTimeMinutes: 4,
      publishDate: DateTime(2026, 8, 20),
      content: '''Diary sakit kepala adalah alat sederhana tetapi ampuh yang membantu Anda dan penyedia layanan kesehatan memahami pola sakit kepala Anda dan mengidentifikasi pemicu.

**Yang Perlu Dicatat**
Untuk setiap episode sakit kepala, catat:
- Tanggal dan waktu awal
- Durasi
- Lokasi nyeri
- Jenis nyeri (berdenyut, menekan, tajam, tumpul)
- Intensitas (skala 1-10)
- Gejala terkait (mual, sensitivitas cahaya, dll.)
- Pemicu yang mungkin
- Obat yang dikonsumsi dan efektivitasnya
- Kualitas tidur malam sebelumnya
- Asupan air
- Aktivitas sebelum sakit kepala

**Informasi Harian Tambahan**
- Suasana hati umum dan tingkat stres
- Pola makan
- Olahraga atau aktivitas fisik
- Kondisi cuaca
- Siklus menstruasi (jika berlaku)

**Manfaat Membuat Diary**
- Mengidentifikasi pemicu yang mungkin tidak Anda sadari
- Menunjukkan pola frekuensi dan keparahan sakit kepala
- Membantu mengevaluasi efektivitas pengobatan
- Menyediakan data berharga untuk kunjungan penyedia layanan kesehatan
- Memberdayakan Anda untuk mengambil peran aktif dalam mengelola kesehatan Anda

**Tips untuk Konsistensi**
- Perbarui diary Anda segera setelah setiap episode
- Gunakan format atau aplikasi yang konsisten
- Tinjau diary Anda secara mingguan untuk melihat pola
- Bawa catatan Anda ke janji temu medis

HeadCare memudahkan Anda mempertahankan diary sakit kepala secara digital, dengan perhitungan otomatis dan deteksi pola.''',
    ),
    EducationArticle(
      id: 'EA007',
      title: 'Stres dan Pola Sakit Kepala',
      summary:
          'Memahami hubungan antara stres dan sakit kepala dapat membantu Anda mengembangkan strategi penanganan yang lebih baik.',
      category: 'Stres',
      readingTimeMinutes: 5,
      publishDate: DateTime(2026, 8, 25),
      content: '''Stres adalah salah satu pemicu sakit kepala yang paling sering dilaporkan. Memahami hubungan ini adalah kunci untuk mengembangkan strategi pengelolaan yang efektif.

**Bagaimana Stres Menyebabkan Sakit Kepala**
Ketika Anda stres, tubuh Anda melepaskan hormon yang menyebabkan otot menegang, terutama di leher dan kulit kepala. Ketegangan otot ini dapat memicu sakit kepala tipe tensi. Stres juga dapat menurunkan ambang nyeri Anda, membuat Anda lebih rentan terhadap sakit kepala.

**Stres Akut vs Kronis**
- Stres akut (jangka pendek) dapat memicu episode sakit kepala individual
- Stres kronis (jangka panjang) dapat meningkatkan frekuensi dan intensitas sakit kepala
- Sakit kepala "let-down" sering terjadi saat relaksasi setelah periode stres

**Teknik Pengelolaan Stres**
- **Pernapasan dalam**: Latihan pernapasan lambat dan dalam
- **Relaksasi otot progresif**: Secara sistematis menegang dan melepaskan kelompok otot
- **Olahraga teratur**: Aktivitas fisik adalah pengurang stres yang ampuh
- **Meditasi mindfulness**: Bahkan 10 menit sehari dapat membantu
- **Manajemen waktu**: Tentukan prioritas tugas dan pecah proyek besar menjadi langkah-langkah lebih kecil
- **Dukungan sosial**: Berbicaralah dengan teman, keluarga, atau konselor

**Membangun Ketahanan**
- Pertahankan rutinitas harian yang konsisten
- Tidur yang cukup
- Makan makanan teratur dan seimbang
- Tetapkan ekspektasi yang realistis untuk diri sendiri
- Belajar mengatakan tidak pada komitmen yang berlebihan
- Ambil istirahat selama sesi kerja atau belajar

**Ketika Stres Menjadi Berlebihan**
Jika stres secara signifikan memengaruhi kualitas hidup atau frekuensi sakit kepala Anda, pertimbangkan untuk berbicara dengan profesional kesehatan mental. Mereka dapat menyediakan strategi dan dukungan yang dipersonalisasi.''',
    ),
    EducationArticle(
      id: 'EA008',
      title: 'Cara Mempersiapkan Konsultasi dengan Dokter',
      summary:
          'Manfaatkan konsultasi jarak jauh Anda dengan mempersiapkan diri secara menyeluruh sebelumnya.',
      category: 'Kunjungi Dokter',
      readingTimeMinutes: 4,
      publishDate: DateTime(2026, 8, 30),
      content: '''Persiapan adalah kunci untuk memiliki konsultasi yang produktif dengan penyedia layanan kesehatan Anda, baik itu kunjungan langsung maupun konsultasi jarak jauh.

**Sebelum Janji Temu Anda**
- Tinjau diary sakit kepala atau catatan HeadCare Anda
- Tulis kekhawatiran dan pertanyaan utama Anda
- Daftar semua obat yang sedang Anda konsumsi, termasuk suplemen
- Catat perubahan apa pun pada gejala Anda sejak kunjungan terakhir
- Sediakan riwayat medis Anda dengan mudah diakses

**Pertanyaan yang Perlu Ditanyakan**
- Jenis sakit kepala apa yang saya alami?
- Apakah ada tes yang harus saya jalani?
- Perubahan gaya hidup apa yang Anda rekomendasikan?
- Pilihan pengobatan apa yang tersedia?
- Kapan saya harus melakukan kunjungan ulang?

**Untuk Konsultasi Jarak Jauh**
- Uji perangkat, kamera, dan mikrofon Anda sebelumnya
- Cari tempat yang tenang dan terang
- Pastikan koneksi internet stabil
- Simpan catatan sakit kepala Anda terlihat untuk referensi
- Siapkan pena dan kertas untuk catatan
- Pastikan privasi selama konsultasi

**Berbagi Data Sakit Kepala Anda**
Jika aplikasi Anda mengizinkannya, bagikan ringkasan sakit kepala Anda dengan dokter sebelum atau selama konsultasi. Ini memberi mereka konteks berharga dan memungkinkan diskusi yang lebih terfokus.

**Setelah Konsultasi**
- Tinjau catatan yang Anda buat
- Ikuti rekomendasi yang diberikan
- Jadwalkan janji temu ulang sesuai kebutuhan
- Perbarui catatan Anda berdasarkan konsultasi

Ingat, waktu konsultasi Anda sangat berharga. Bersiap membantu memastikan Anda mendapatkan hasil maksimal dari setiap interaksi dengan penyedia layanan kesehatan Anda.''',
    ),
  ];

  static final List<AppNotification> notifications = [
    AppNotification(
      id: 'N001',
      title: 'Ringkasan Mingguan Siap',
      message: 'Ringkasan sakit kepala mingguan Anda sudah siap. Anda mengalami 2 episode minggu ini.',
      dateTime: DateTime(2026, 9, 10, 18, 0),
      type: NotificationType.monitoring,
      isRead: false,
    ),
    AppNotification(
      id: 'N002',
      title: 'Konsultasi Mendatang',
      message: 'Anda memiliki konsultasi besok pukul 19:30 dengan dr. Nadia Pratama.',
      dateTime: DateTime(2026, 9, 10, 12, 0),
      type: NotificationType.appointment,
      isRead: false,
    ),
    AppNotification(
      id: 'N003',
      title: 'Pengingat Check-in Harian',
      message: 'Anda belum mencatat gejala hari ini. Bagaimana perasaan Anda?',
      dateTime: DateTime(2026, 9, 10, 9, 0),
      type: NotificationType.reminder,
      isRead: true,
    ),
    AppNotification(
      id: 'N004',
      title: 'Artikel Tersedia',
      message: 'Artikel edukasi baru: "Cara Mempersiapkan Konsultasi dengan Dokter"',
      dateTime: DateTime(2026, 9, 9, 14, 0),
      type: NotificationType.education,
      isRead: true,
    ),
    AppNotification(
      id: 'N005',
      title: 'Pengingat Asesmen',
      message: 'Sudah 2 minggu sejak asesmen terakhir Anda. Pertimbangkan untuk mengambil yang baru.',
      dateTime: DateTime(2026, 9, 8, 10, 0),
      type: NotificationType.reminder,
      isRead: true,
    ),
    AppNotification(
      id: 'N006',
      title: 'Pola Sakit Kepala Terdeteksi',
      message: 'Catatan Anda menunjukkan sakit kepala lebih sering terjadi pada hari-hari dengan tidur kurang dari 6 jam.',
      dateTime: DateTime(2026, 9, 7, 16, 0),
      type: NotificationType.monitoring,
      isRead: true,
    ),
  ];

  static final List<HealthInsight> healthInsights = [
    HealthInsight(
      id: 'HI001',
      title: 'Hubungan Tidur-Sakit Kepala',
      description:
          'Catatan Anda menunjukkan sakit kepala lebih sering terjadi pada hari-hari ketika Anda tidur kurang dari 6 jam. Dalam 30 hari terakhir, 6 dari 8 episode diikuti oleh malam tidur yang buruk.',
      type: HealthInsightType.lifestyle,
      date: DateTime(2026, 9, 10),
    ),
    HealthInsight(
      id: 'HI002',
      title: 'Pola Waktu Umum',
      description:
          'Sebagian besar sakit kepala yang Anda catat terjadi pada sore hari antara pukul 14:00 dan 17:00. Pola ini mungkin berkaitan dengan paparan layar dan waktu makan.',
      type: HealthInsightType.pattern,
      date: DateTime(2026, 9, 10),
    ),
    HealthInsight(
      id: 'HI003',
      title: 'Frekuensi Pemicu',
      description:
          'Kurang tidur, paparan layar, dan stres adalah pemicu yang paling sering Anda catat. Faktor-faktor ini sering muncul bersamaan dalam catatan Anda.',
      type: HealthInsightType.trigger,
      date: DateTime(2026, 9, 9),
    ),
    HealthInsight(
      id: 'HI004',
      title: 'Perbandingan Mingguan',
      description:
          'Episode yang Anda catat menurun dari 3 episode minggu lalu menjadi 2 episode minggu ini. Terus lacak untuk memantau kemajuan Anda.',
      type: HealthInsightType.comparison,
      date: DateTime(2026, 9, 10),
    ),
  ];

  static final List<DailyCheckin> recentCheckins = [
    DailyCheckin(
      id: 'DC001',
      date: DateTime(2026, 9, 11),
      mood: 'Biasa',
      moodScore: 3,
    ),
    DailyCheckin(
      id: 'DC002',
      date: DateTime(2026, 9, 10),
      mood: 'Tidak Baik',
      moodScore: 2,
    ),
    DailyCheckin(
      id: 'DC003',
      date: DateTime(2026, 9, 9),
      mood: 'Biasa',
      moodScore: 3,
    ),
    DailyCheckin(
      id: 'DC004',
      date: DateTime(2026, 9, 8),
      mood: 'Bagus',
      moodScore: 5,
    ),
    DailyCheckin(
      id: 'DC005',
      date: DateTime(2026, 9, 7),
      mood: 'Biasa',
      moodScore: 3,
    ),
    DailyCheckin(
      id: 'DC006',
      date: DateTime(2026, 9, 6),
      mood: 'Tidak Baik',
      moodScore: 2,
    ),
    DailyCheckin(
      id: 'DC007',
      date: DateTime(2026, 9, 5),
      mood: 'Bagus',
      moodScore: 5,
    ),
  ];

  static final List<AssessmentQuestion> assessmentQuestions = [
    AssessmentQuestion(
      id: 'Q1',
      question: 'Berapa kali Anda mengalami sakit kepala dalam 30 hari terakhir?',
      options: ['Tidak ada', '1-2 kali', '3-5 kali', '6-10 kali', 'Lebih dari 10 kali'],
      category: 'Frekuensi',
    ),
    AssessmentQuestion(
      id: 'Q2',
      question: 'Rata-rata, berapa lama setiap episode sakit kepala berlangsung?',
      options: ['Kurang dari 1 jam', '1-3 jam', '3-6 jam', '6-12 jam', 'Lebih dari 12 jam'],
      category: 'Durasi',
    ),
    AssessmentQuestion(
      id: 'Q3',
      question: 'Seberapa intens rasa sakit yang biasa Anda rasakan? (1 = sangat ringan, 10 = sangat berat)',
      options: ['1-2 (Sangat ringan)', '3-4 (Ringan)', '5-6 (Sedang)', '7-8 (Berat)', '9-10 (Sangat berat)'],
      category: 'Intensitas',
    ),
    AssessmentQuestion(
      id: 'Q4',
      question: 'Apakah sakit kepala Anda mengganggu aktivitas sehari-hari?',
      options: ['Tidak sama sekali', 'Sedikit', 'Sedang', 'Sangat', 'Sepenuhnya'],
      category: 'Dampak',
    ),
    AssessmentQuestion(
      id: 'Q5',
      question: 'Apakah Anda mengalami sensitivitas terhadap cahaya saat sakit kepala?',
      options: ['Tidak pernah', 'Jarang', 'Kadang-kadang', 'Sering', 'Selalu'],
      category: 'Gejala',
    ),
    AssessmentQuestion(
      id: 'Q6',
      question: 'Apakah Anda mengalami sensitivitas terhadap suara saat sakit kepala?',
      options: ['Tidak pernah', 'Jarang', 'Kadang-kadang', 'Sering', 'Selalu'],
      category: 'Gejala',
    ),
    AssessmentQuestion(
      id: 'Q7',
      question: 'Apakah Anda mengalami mual atau muntah saat sakit kepala?',
      options: ['Tidak pernah', 'Jarang', 'Kadang-kadang', 'Sering', 'Selalu'],
      category: 'Gejala',
    ),
    AssessmentQuestion(
      id: 'Q8',
      question: 'Seberapa sering Anda mengonsumsi obat pereda nyeri untuk sakit kepala?',
      options: ['Tidak pernah', 'Kurang dari sekali seminggu', '1-2 kali seminggu', '3-4 kali seminggu', 'Setiap hari atau hampir setiap hari'],
      category: 'Obat',
    ),
    AssessmentQuestion(
      id: 'Q9',
      question: 'Apakah sakit kepala membuat Anda melewatkan aktivitas kerja, sekolah, atau sosial?',
      options: ['Tidak pernah', 'Jarang (sekali sebulan)', 'Kadang-kadang (2-3 kali sebulan)', 'Sering (setiap minggu)', 'Sangat sering'],
      category: 'Dampak',
    ),
    AssessmentQuestion(
      id: 'Q10',
      question: 'Bagaimana Anda menilai kualitas hidup Anda dalam mengelola sakit kepala?',
      options: ['Sangat baik', 'Baik', 'Cukup', 'Buruk', 'Sangat buruk'],
      category: 'Kualitas Hidup',
    ),
  ];

  static int get episodesThisWeek {
    final now = DateTime(2026, 9, 11);
    final weekAgo = now.subtract(const Duration(days: 7));
    return headacheEpisodes.where((e) => e.startTime.isAfter(weekAgo)).length;
  }

  static int get episodesLastWeek {
    final now = DateTime(2026, 9, 11);
    final weekAgo = now.subtract(const Duration(days: 7));
    final twoWeeksAgo = now.subtract(const Duration(days: 14));
    return headacheEpisodes
        .where((e) => e.startTime.isAfter(twoWeeksAgo) && e.startTime.isBefore(weekAgo))
        .length;
  }

  static double get averageIntensity30Days {
    final now = DateTime(2026, 9, 11);
    final thirtyDaysAgo = now.subtract(const Duration(days: 30));
    final episodes = headacheEpisodes.where((e) => e.startTime.isAfter(thirtyDaysAgo)).toList();
    if (episodes.isEmpty) return 0;
    return episodes.map((e) => e.intensity).reduce((a, b) => a + b) / episodes.length;
  }

  static Duration get averageDuration30Days {
    final now = DateTime(2026, 9, 11);
    final thirtyDaysAgo = now.subtract(const Duration(days: 30));
    final episodes = headacheEpisodes.where((e) => e.startTime.isAfter(thirtyDaysAgo)).toList();
    if (episodes.isEmpty) return Duration.zero;
    final totalMinutes = episodes.map((e) => e.duration.inMinutes).reduce((a, b) => a + b);
    return Duration(minutes: totalMinutes ~/ episodes.length);
  }

  static String get mostCommonTime {
    final hours = headacheEpisodes.map((e) => e.startTime.hour).toList();
    if (hours.isEmpty) return 'N/A';
    final counts = <int, int>{};
    for (final h in hours) {
      final period = h < 12 ? 0 : (h < 17 ? 1 : 2);
      counts[period] = (counts[period] ?? 0) + 1;
    }
    final maxEntry = counts.entries.reduce((a, b) => a.value > b.value ? a : b);
    switch (maxEntry.key) {
      case 0:
        return 'Pagi';
      case 1:
        return 'Siang';
      case 2:
        return 'Malam';
      default:
        return 'Siang';
    }
  }

  static Map<String, int> get triggerFrequency {
    final counts = <String, int>{};
    for (final episode in headacheEpisodes) {
      for (final trigger in episode.triggers) {
        final label = trigger.toString().split('.').last;
        final readable = label.replaceAllMapped(
          RegExp(r'([A-Z])'),
          (m) => ' ${m.group(1)}',
        ).trim();
        counts[readable] = (counts[readable] ?? 0) + 1;
      }
    }
    return Map.fromEntries(
      counts.entries.toList()..sort((a, b) => b.value.compareTo(a.value)),
    );
  }
}
