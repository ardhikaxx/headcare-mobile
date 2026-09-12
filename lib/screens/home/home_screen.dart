import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../data/mock_data.dart';
import '../../models/models.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _todayMood = 'Bagus';
  int _waterGlasses = 5;
  int _selectedDayIndex = 5; // Saturday (today)
  final Set<String> _todayTriggers = {'Layar >4j'};

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour >= 4 && hour < 11) return 'Selamat pagi';
    if (hour >= 11 && hour < 15) return 'Selamat siang';
    if (hour >= 15 && hour < 18) return 'Selamat sore';
    return 'Selamat malam';
  }

  IconData _greetingIcon() {
    final hour = DateTime.now().hour;
    if (hour >= 4 && hour < 15) return LucideIcons.sun;
    if (hour >= 15 && hour < 18) return LucideIcons.sunset;
    return LucideIcons.moon;
  }

  @override
  Widget build(BuildContext context) {
    final episodesThisWeek = MockData.episodesThisWeek;
    final avgIntensity = MockData.averageIntensity30Days;
    final avgDuration = MockData.averageDuration30Days;
    final mostCommonTime = MockData.mostCommonTime;
    final featuredDoctor = MockData.doctors.first;
    final topArticles = MockData.educationArticles.take(2).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Decorative Ambient Background Orbs
          Positioned(
            top: -60,
            left: -40,
            child: Container(
              width: 230,
              height: 230,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primaryLight.withAlpha(45),
                    AppColors.primary.withAlpha(0),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 140,
            right: -60,
            child: Container(
              width: 210,
              height: 210,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.secondary.withAlpha(40),
                    AppColors.secondary.withAlpha(0),
                  ],
                ),
              ),
            ),
          ),

          // Main Scrollable Content
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 120),
              children: [
                const SizedBox(height: 12),

                // 1. Decorative Header Bar
                _buildHeaderBar(context),

                const SizedBox(height: 18),

                // 2. Health Status Hero Card (Deep Decorative Layering)
                _buildHealthHeroCard(
                  context: context,
                  episodesThisWeek: episodesThisWeek,
                  avgIntensity: avgIntensity,
                  avgDuration: avgDuration,
                  mostCommonTime: mostCommonTime,
                ),

                const SizedBox(height: 22),

                // 3. Weekly Mini Tracker Strip (Kalender Tren 7 Hari)
                _buildWeeklyCalendarStrip(context, episodesThisWeek),

                const SizedBox(height: 24),

                // 4. Quick Actions Grid (Decorative Themed Tiles)
                _buildSectionHeader(
                  title: 'Akses Cepat',
                  badgeText: 'Fitur Utama',
                  badgeColor: AppColors.primary,
                ),
                const SizedBox(height: 14),
                _buildQuickActionsGrid(context),

                const SizedBox(height: 24),

                // 5. Daily Wellness & Interactive Check-in Card (with Triggers & Hydration)
                _buildWellnessCheckInCard(context),

                const SizedBox(height: 24),

                // 6. Guided Breathing & Relaxation Card (Fitur Relaksasi Dekoratif)
                _buildRelaxationCard(context),

                const SizedBox(height: 24),

                // 7. Upcoming Teleconsultation Spotlight Card
                _buildSectionHeader(
                  title: 'Konsultasi Dokter',
                  badgeText: 'Jadwal Aktif',
                  badgeColor: AppColors.success,
                  trailingText: 'Lihat Semua',
                  onTrailingTap: () => Navigator.pushNamed(context, '/consult'),
                ),
                const SizedBox(height: 14),
                _buildDoctorSpotlightCard(context, featuredDoctor),

                const SizedBox(height: 24),

                // 8. Health Insights & Actionable Tips
                _buildSectionHeader(
                  title: 'Insight & Rekomendasi',
                  badgeText: 'AI Analisis',
                  badgeColor: AppColors.info,
                ),
                const SizedBox(height: 14),
                _buildHealthInsightsList(context),

                const SizedBox(height: 24),

                // 9. Articles Preview Carousel
                _buildSectionHeader(
                  title: 'Edukasi Sakit Kepala',
                  badgeText: 'Tips Sehat',
                  badgeColor: AppColors.warning,
                  trailingText: 'Semua Artikel',
                  onTrailingTap: () => Navigator.pushNamed(context, '/education'),
                ),
                const SizedBox(height: 14),
                _buildArticlesPreview(context, topArticles),

                const SizedBox(height: 22),

                // 10. Emergency & Red Flags Assistance Card
                _buildEmergencyBanner(context),

                const SizedBox(height: 20),

                // 11. Medical Disclaimer Footer
                _buildDisclaimerCard(),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // 1. DECORATIVE HEADER BAR
  // ==========================================
  Widget _buildHeaderBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.surface.withAlpha(235),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.border.withAlpha(180), width: 1),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowMedium,
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            // User Avatar with glowing status ring
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2563EB), Color(0xFF06B6D4)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withAlpha(50),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'YA',
                      style: AppTypography.titleMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 13,
                  height: 13,
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),

            // Greeting and Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Icon(
                        _greetingIcon(),
                        size: 15,
                        color: const Color(0xFFF59E0B),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${_greeting()}, Yanuar',
                        style: AppTypography.titleMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.successLight,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.verified_rounded,
                              size: 12,
                              color: Color(0xFF15803D),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '3 Hari Bebas Nyeri',
                              style: AppTypography.labelSmall.copyWith(
                                color: const Color(0xFF15803D),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Notification Bell Button with Unread Badge
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/notifications'),
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(
                      LucideIcons.bell,
                      size: 20,
                      color: AppColors.textPrimary,
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppColors.danger,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // 2. HEALTH STATUS HERO CARD (DECORATIVE)
  // ==========================================
  Widget _buildHealthHeroCard({
    required BuildContext context,
    required int episodesThisWeek,
    required double avgIntensity,
    required Duration avgDuration,
    required String mostCommonTime,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withAlpha(60),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(26),
          child: Stack(
            children: [
              // Deep Gradient Background
              Container(
                padding: const EdgeInsets.all(22),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF1D4ED8),
                      Color(0xFF2563EB),
                      Color(0xFF0284C7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Status Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Status Pill with glowing green pulse
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(35),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withAlpha(50),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF4ADE80),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Kondisi Sebagian Besar Stabil',
                                style: AppTypography.labelSmall.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Sparkline / Mini Trend Indicator
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(30),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            LucideIcons.activity,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Main Headline & Description
                    Text(
                      'Pola Sakit Kepala Anda',
                      style: AppTypography.headlineMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$episodesThisWeek episode tercatat minggu ini · Turun 25% dari pekan lalu',
                      style: AppTypography.bodySmall.copyWith(
                        color: Colors.white.withAlpha(220),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 3 Glassmorphic Metric Pods
                    Row(
                      children: [
                        Expanded(
                          child: _buildGlassPod(
                            icon: LucideIcons.heartPulse,
                            iconColor: const Color(0xFFFDA4AF),
                            value: avgIntensity.toStringAsFixed(1),
                            unit: '/ 10',
                            label: 'Rata-rata Nyeri',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildGlassPod(
                            icon: LucideIcons.clock,
                            iconColor: const Color(0xFFBAE6FD),
                            value: '${avgDuration.inHours}h ${avgDuration.inMinutes % 60}m',
                            unit: '',
                            label: 'Rata-rata Durasi',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildGlassPod(
                            icon: LucideIcons.sun,
                            iconColor: const Color(0xFFFDE68A),
                            value: mostCommonTime,
                            unit: '',
                            label: 'Waktu Rentan',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // Direct Action CTA within Hero
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/log-headache'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(25),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withAlpha(25),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                LucideIcons.plus,
                                size: 16,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Catat Episode Sakit Kepala Baru',
                              style: AppTypography.button.copyWith(
                                color: AppColors.primaryDark,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              LucideIcons.arrowRight,
                              size: 16,
                              color: AppColors.primary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Decorative Translucent Circular Rings
              Positioned(
                top: -30,
                right: -30,
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withAlpha(25),
                      width: 24,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -40,
                left: -20,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withAlpha(15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGlassPod({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String unit,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(28),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withAlpha(45),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: iconColor),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: AppTypography.titleMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (unit.isNotEmpty) ...[
                const SizedBox(width: 2),
                Text(
                  unit,
                  style: AppTypography.labelSmall.copyWith(
                    color: Colors.white.withAlpha(180),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(
              color: Colors.white.withAlpha(200),
              fontSize: 9.5,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // ==========================================
  // 3. WEEKLY CALENDAR STRIP (DECORATIVE 7 DAYS)
  // ==========================================
  Widget _buildWeeklyCalendarStrip(BuildContext context, int episodesThisWeek) {
    final days = [
      {'day': 'Min', 'date': '6', 'status': 'episode', 'intensity': '7'},
      {'day': 'Sen', 'date': '7', 'status': 'clean', 'intensity': '0'},
      {'day': 'Sel', 'date': '8', 'status': 'mild', 'intensity': '4'},
      {'day': 'Rab', 'date': '9', 'status': 'clean', 'intensity': '0'},
      {'day': 'Kam', 'date': '10', 'status': 'episode', 'intensity': '6'},
      {'day': 'Jum', 'date': '11', 'status': 'clean', 'intensity': '0'},
      {'day': 'Sab', 'date': '12', 'status': 'today', 'intensity': '0'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowMedium,
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withAlpha(15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        LucideIcons.calendar,
                        size: 16,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Kalender Tren Mingguan',
                      style: AppTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/weekly-summary'),
                  child: Row(
                    children: [
                      Text(
                        'Ringkasan',
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(
                        LucideIcons.chevronRight,
                        size: 14,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 7 Days Pill Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(days.length, (index) {
                final item = days[index];
                final isSelected = _selectedDayIndex == index;
                final isToday = item['status'] == 'today';
                final isEpisode = item['status'] == 'episode';
                final isMild = item['status'] == 'mild';

                Color dotColor;
                if (isEpisode) {
                  dotColor = AppColors.danger;
                } else if (isMild) {
                  dotColor = AppColors.warning;
                } else {
                  dotColor = AppColors.success;
                }

                return GestureDetector(
                  onTap: () => setState(() => _selectedDayIndex = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 42,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: isToday
                          ? AppColors.primary
                          : isSelected
                              ? AppColors.primary.withAlpha(20)
                              : AppColors.background,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isToday
                            ? AppColors.primaryDark
                            : isSelected
                                ? AppColors.primary
                                : AppColors.borderLight,
                        width: isToday || isSelected ? 1.5 : 1,
                      ),
                      boxShadow: isToday
                          ? [
                              BoxShadow(
                                color: AppColors.primary.withAlpha(70),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ]
                          : null,
                    ),
                    child: Column(
                      children: [
                        Text(
                          item['day']!,
                          style: AppTypography.labelSmall.copyWith(
                            color: isToday
                                ? Colors.white.withAlpha(220)
                                : AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['date']!,
                          style: AppTypography.titleMedium.copyWith(
                            color: isToday ? Colors.white : AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        // Status indicator dot
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: isToday ? Colors.white : dotColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 14),

            // Legend Information
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildLegendItem(AppColors.success, 'Bebas Nyeri (4 Hari)'),
                  _buildLegendItem(AppColors.warning, 'Ringan (1)'),
                  _buildLegendItem(AppColors.danger, 'Episode (2)'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: AppTypography.labelSmall.copyWith(
            color: AppColors.textSecondary,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  // ==========================================
  // 4. QUICK ACTIONS GRID (DECORATIVE THEMED TILES)
  // ==========================================
  Widget _buildQuickActionsGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // 1. Log Headache
          Expanded(
            child: _buildActionTile(
              context: context,
              title: 'Catat Episode',
              subtitle: 'Nyeri & pemicu',
              badgeText: 'Cepat',
              badgeIcon: LucideIcons.zap,
              icon: LucideIcons.plusCircle,
              iconColor: const Color(0xFF2563EB),
              gradientStart: const Color(0xFFEFF6FF),
              gradientEnd: const Color(0xFFDBEAFE),
              borderColor: const Color(0xFFBFDBFE),
              onTap: () => Navigator.pushNamed(context, '/log-headache'),
            ),
          ),
          const SizedBox(width: 12),

          // 2. Self Assessment
          Expanded(
            child: _buildActionTile(
              context: context,
              title: 'Asesmen Diri',
              subtitle: 'Skrining risiko',
              badgeText: '10 Soal',
              badgeIcon: LucideIcons.fileText,
              icon: LucideIcons.clipboardCheck,
              iconColor: const Color(0xFF059669),
              gradientStart: const Color(0xFFECFDF5),
              gradientEnd: const Color(0xFFD1FAE5),
              borderColor: const Color(0xFFA7F3D0),
              onTap: () => Navigator.pushNamed(context, '/assessment'),
            ),
          ),
          const SizedBox(width: 12),

          // 3. Teleconsultation
          Expanded(
            child: _buildActionTile(
              context: context,
              title: 'Konsultasi',
              subtitle: 'Dokter spesialis',
              badgeText: 'Online',
              badgeIcon: Icons.circle,
              icon: LucideIcons.stethoscope,
              iconColor: const Color(0xFF7C3AED),
              gradientStart: const Color(0xFFF5F3FF),
              gradientEnd: const Color(0xFFEDE9FE),
              borderColor: const Color(0xFFDDD6FE),
              onTap: () => Navigator.pushNamed(context, '/consult'),
            ),
          ),
          const SizedBox(width: 12),

          // 4. Education
          Expanded(
            child: _buildActionTile(
              context: context,
              title: 'Edukasi',
              subtitle: 'Tips & artikel',
              badgeText: 'Panduan',
              badgeIcon: LucideIcons.bookOpen,
              icon: LucideIcons.bookOpen,
              iconColor: const Color(0xFFD97706),
              gradientStart: const Color(0xFFFFFBEB),
              gradientEnd: const Color(0xFFFEF3C7),
              borderColor: const Color(0xFFFDE68A),
              onTap: () => Navigator.pushNamed(context, '/education'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String badgeText,
    required IconData badgeIcon,
    required IconData icon,
    required Color iconColor,
    required Color gradientStart,
    required Color gradientEnd,
    required Color borderColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [gradientStart, gradientEnd],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: borderColor, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: iconColor.withAlpha(25),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Icon Container with inner glow
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: iconColor.withAlpha(40),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(icon, size: 22, color: iconColor),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: AppTypography.labelMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.textSecondary,
                fontSize: 9,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // 5. DAILY WELLNESS & INTERACTIVE CHECK-IN CARD
  // ==========================================
  Widget _buildWellnessCheckInCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowMedium,
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with sparkles icon
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF3C7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    LucideIcons.sparkles,
                    size: 18,
                    color: Color(0xFFD97706),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Check-in Kebugaran Hari Ini',
                        style: AppTypography.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Bagaimana sensasi di kepala Anda saat ini?',
                        style: AppTypography.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 4 Interactive Mood Options (pure vector icons)
            Row(
              children: [
                _buildInteractiveMood(
                  icon: Icons.sentiment_very_satisfied_rounded,
                  label: 'Sangat Baik',
                  desc: 'Bebas nyeri',
                  value: 'Sangat Baik',
                  accentColor: const Color(0xFF10B981),
                ),
                const SizedBox(width: 8),
                _buildInteractiveMood(
                  icon: Icons.sentiment_satisfied_alt_rounded,
                  label: 'Nyaman',
                  desc: 'Kondisi rileks',
                  value: 'Bagus',
                  accentColor: const Color(0xFF3B82F6),
                ),
                const SizedBox(width: 8),
                _buildInteractiveMood(
                  icon: Icons.sentiment_neutral_rounded,
                  label: 'Pusing',
                  desc: 'Sedikit tegang',
                  value: 'Biasa',
                  accentColor: const Color(0xFFF59E0B),
                ),
                const SizedBox(width: 8),
                _buildInteractiveMood(
                  icon: Icons.sentiment_very_dissatisfied_rounded,
                  label: 'Nyeri',
                  desc: 'Perlu istirahat',
                  value: 'Tidak Baik',
                  accentColor: const Color(0xFFEF4444),
                ),
              ],
            ),

            // Feedback Message Banner
            if (_todayMood != null) ...[
              const SizedBox(height: 14),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _getMoodBannerColor(_todayMood!).withAlpha(25),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: _getMoodBannerColor(_todayMood!).withAlpha(80),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _todayMood == 'Tidak Baik'
                          ? LucideIcons.alertTriangle
                          : LucideIcons.checkCircle2,
                      size: 20,
                      color: _getMoodBannerColor(_todayMood!),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _getMoodAdviceText(_todayMood!),
                        style: AppTypography.bodySmall.copyWith(
                          color: _getMoodBannerColor(_todayMood!),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    if (_todayMood == 'Tidak Baik') ...[
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/log-headache'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.danger,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Catat',
                            style: AppTypography.labelSmall.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],

            const SizedBox(height: 18),
            const Divider(color: AppColors.borderLight, height: 1),
            const SizedBox(height: 16),

            // Today's Exposure & Triggers Quick Checklist
            Text(
              'Paparan yang Anda Rasakan Hari Ini',
              style: AppTypography.labelSmall.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                _buildTriggerChip('Layar >4j', LucideIcons.monitor),
                _buildTriggerChip('Kurang Tidur', LucideIcons.moon),
                _buildTriggerChip('Dehidrasi', LucideIcons.droplets),
                _buildTriggerChip('Beban Stres', LucideIcons.zap),
                _buildTriggerChip('Telat Makan', LucideIcons.clock),
              ],
            ),

            const SizedBox(height: 16),
            const Divider(color: AppColors.borderLight, height: 1),
            const SizedBox(height: 16),

            // Daily Hydration & Sleep Mini Trackers
            Row(
              children: [
                // Hydration Tracker (Interactive + / -)
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F9FF),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFBAE6FD)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              LucideIcons.droplets,
                              size: 16,
                              color: Color(0xFF0284C7),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Target Air Minum',
                              style: AppTypography.labelSmall.copyWith(
                                color: const Color(0xFF0369A1),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '$_waterGlasses / 8 Gelas',
                              style: AppTypography.titleMedium.copyWith(
                                color: const Color(0xFF0C4A6E),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (_waterGlasses > 0) {
                                      setState(() => _waterGlasses--);
                                    }
                                  },
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(0xFFBAE6FD),
                                      ),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.remove,
                                        size: 14,
                                        color: Color(0xFF0284C7),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                GestureDetector(
                                  onTap: () {
                                    if (_waterGlasses < 12) {
                                      setState(() => _waterGlasses++);
                                    }
                                  },
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF0284C7),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.add,
                                        size: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: (_waterGlasses / 8).clamp(0.0, 1.0),
                            backgroundColor: const Color(0xFFE0F2FE),
                            valueColor: const AlwaysStoppedAnimation(Color(0xFF0284C7)),
                            minHeight: 5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Sleep Metric Pod
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F3FF),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFDDD6FE)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              LucideIcons.moon,
                              size: 16,
                              color: Color(0xFF7C3AED),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Waktu Tidur',
                              style: AppTypography.labelSmall.copyWith(
                                color: const Color(0xFF6D28D9),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '7.5 Jam',
                          style: AppTypography.titleMedium.copyWith(
                            color: const Color(0xFF4C1D95),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.check_circle_rounded,
                                size: 12,
                                color: Color(0xFF7C3AED),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Kualitas Optimal',
                                style: AppTypography.labelSmall.copyWith(
                                  color: const Color(0xFF7C3AED),
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTriggerChip(String label, IconData icon) {
    final isSelected = _todayTriggers.contains(label);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _todayTriggers.remove(label);
          } else {
            _todayTriggers.add(label);
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEFF6FF) : AppColors.background,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 12,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: AppTypography.labelSmall.copyWith(
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractiveMood({
    required IconData icon,
    required String label,
    required String desc,
    required String value,
    required Color accentColor,
  }) {
    final isSelected = _todayMood == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _todayMood = value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
          decoration: BoxDecoration(
            color: isSelected
                ? accentColor.withAlpha(20)
                : AppColors.background,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? accentColor : AppColors.border,
              width: isSelected ? 1.8 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: accentColor.withAlpha(30),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : null,
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: isSelected
                      ? accentColor.withAlpha(25)
                      : Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 24,
                  color: isSelected ? accentColor : AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: AppTypography.labelSmall.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected ? accentColor : AppColors.textPrimary,
                  fontSize: 10,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getMoodBannerColor(String mood) {
    switch (mood) {
      case 'Sangat Baik':
        return const Color(0xFF059669);
      case 'Bagus':
        return AppColors.primary;
      case 'Biasa':
        return AppColors.warning;
      case 'Tidak Baik':
        return AppColors.danger;
      default:
        return AppColors.primary;
    }
  }

  String _getMoodAdviceText(String mood) {
    switch (mood) {
      case 'Sangat Baik':
        return 'Kondisi sangat baik! Pertahankan pola tidur dan hidrasi yang teratur hari ini.';
      case 'Bagus':
        return 'Kondisi prima. Jangan lupa istirahat mata setiap 20 menit saat bekerja.';
      case 'Biasa':
        return 'Ada pusing ringan? Minumlah segelas air dan regangkan leher Anda sejenak.';
      case 'Tidak Baik':
        return 'Sakit kepala terasa? Disarankan istirahat di ruangan redup atau minum obat.';
      default:
        return 'Terima kasih telah berbagi kondisi harian Anda!';
    }
  }

  // ==========================================
  // 6. GUIDED RELAXATION CARD (DECORATIVE FEATURE)
  // ==========================================
  Widget _buildRelaxationCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFF0FDF4), Color(0xFFDCFCE7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: const Color(0xFFBBF7D0)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF16A34A).withAlpha(20),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF16A34A).withAlpha(30),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  LucideIcons.wind,
                  color: Color(0xFF16A34A),
                  size: 24,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Relaksasi Pernapasan 4-7-8',
                    style: AppTypography.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF14532D),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Redakan ketegangan otot leher & saraf pemicu sakit kepala.',
                    style: AppTypography.caption.copyWith(
                      color: const Color(0xFF166534),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    title: Row(
                      children: [
                        const Icon(
                          LucideIcons.wind,
                          color: Color(0xFF16A34A),
                          size: 22,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Pernapasan 4-7-8',
                          style: AppTypography.titleLarge,
                        ),
                      ],
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: const Color(0xFFDCFCE7),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF16A34A),
                              width: 2,
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              LucideIcons.heartPulse,
                              size: 36,
                              color: Color(0xFF16A34A),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '1. Tarik napas pelan melalui hidung (4 detik)\n2. Tahan napas dengan rileks (7 detik)\n3. Hembuskan perlahan lewat mulut (8 detik)',
                          style: AppTypography.bodySmall.copyWith(height: 1.6),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0FDF4),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Ulangi siklus ini 4 kali untuk hasil optimal.',
                            style: AppTypography.labelSmall.copyWith(
                              color: const Color(0xFF15803D),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(ctx),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF16A34A),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Selesai'),
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF16A34A),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Latihan',
                  style: AppTypography.labelSmall.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // 7. DOCTOR SPOTLIGHT / APPOINTMENT CARD
  // ==========================================
  Widget _buildDoctorSpotlightCard(BuildContext context, Doctor doctor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: const LinearGradient(
            colors: [Color(0xFFF8FAFC), Color(0xFFEEF2F6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowMedium,
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              // Doctor Bio Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Doctor Avatar with Verified badge
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withAlpha(25),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Center(
                          child: Text(
                            doctor.name.split(' ').last[0],
                            style: AppTypography.displaySmall.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.verified,
                          size: 16,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 14),

                  // Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.successLight,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'Tersedia Hari Ini',
                                style: AppTypography.labelSmall.copyWith(
                                  color: AppColors.success,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9.5,
                                ),
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.star_rounded,
                              size: 16,
                              color: AppColors.warning,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              '${doctor.rating}',
                              style: AppTypography.labelMedium.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${doctor.name}, ${doctor.title}',
                          style: AppTypography.titleMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${doctor.specialty} · ${doctor.experienceYears} thn pengalaman',
                          style: AppTypography.caption,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Booking Time & Consultation Action
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          LucideIcons.video,
                          size: 16,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Sesi Video: Hari ini 20:00 WIB',
                          style: AppTypography.labelMedium.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        '/doctor-detail',
                        arguments: doctor,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Konsultasi',
                          style: AppTypography.button.copyWith(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================
  // 8. HEALTH INSIGHTS LIST
  // ==========================================
  Widget _buildHealthInsightsList(BuildContext context) {
    final insights = MockData.healthInsights.take(2).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: insights.map((insight) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowMedium,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFEFF6FF), Color(0xFFDBEAFE)],
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    LucideIcons.lightbulb,
                    size: 20,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.infoLight,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'Pola Terdeteksi',
                              style: AppTypography.labelSmall.copyWith(
                                color: AppColors.info,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        insight.title,
                        style: AppTypography.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        insight.description,
                        style: AppTypography.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // ==========================================
  // 9. ARTICLES PREVIEW CAROUSEL
  // ==========================================
  Widget _buildArticlesPreview(
    BuildContext context,
    List<EducationArticle> articles,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: articles.map((article) {
          return GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              '/article-detail',
              arguments: article,
            ),
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowMedium,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      LucideIcons.bookOpen,
                      size: 22,
                      color: Color(0xFFD97706),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFEF3C7),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                article.category,
                                style: AppTypography.labelSmall.copyWith(
                                  color: const Color(0xFFB45309),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${article.readingTimeMinutes} mnt baca',
                              style: AppTypography.labelSmall,
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          article.title,
                          style: AppTypography.titleMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          article.summary,
                          style: AppTypography.bodySmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    LucideIcons.chevronRight,
                    size: 18,
                    color: AppColors.textTertiary,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ==========================================
  // 10. EMERGENCY & RED FLAGS BANNER
  // ==========================================
  Widget _buildEmergencyBanner(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/emergency'),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFEF2F2), Color(0xFFFEE2E2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: const Color(0xFFFECACA)),
            boxShadow: [
              BoxShadow(
                color: AppColors.danger.withAlpha(20),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: AppColors.danger,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.danger.withAlpha(60),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.emergency_rounded,
                  size: 26,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Pusat Bantuan & Red Flags',
                          style: AppTypography.titleMedium.copyWith(
                            color: AppColors.danger,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.danger,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Kenali tanda bahaya sakit kepala yang butuh penanganan IGD segera.',
                      style: AppTypography.bodySmall.copyWith(
                        color: const Color(0xFF991B1B),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              const Icon(
                LucideIcons.chevronRight,
                size: 20,
                color: AppColors.danger,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================
  // 11. DISCLAIMER FOOTER
  // ==========================================
  Widget _buildDisclaimerCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.verified_user_outlined,
              size: 16,
              color: AppColors.textTertiary,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'HeadCare adalah sarana pemantauan mandiri dan telekonsultasi. Hasil asesmen bukan diagnosis klinis. Konsultasikan selalu keluhan Anda ke dokter profesional.',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textTertiary,
                  fontSize: 10,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // HELPER: SECTION HEADER
  // ==========================================
  Widget _buildSectionHeader({
    required String title,
    required String badgeText,
    required Color badgeColor,
    String? trailingText,
    VoidCallback? onTrailingTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                title,
                style: AppTypography.headlineSmall.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: badgeColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  badgeText,
                  style: AppTypography.labelSmall.copyWith(
                    color: badgeColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 9.5,
                  ),
                ),
              ),
            ],
          ),
          if (trailingText != null)
            GestureDetector(
              onTap: onTrailingTap,
              child: Row(
                children: [
                  Text(
                    trailingText,
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 2),
                  const Icon(
                    LucideIcons.chevronRight,
                    size: 14,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
