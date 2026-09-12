import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../data/mock_data.dart';
import '../../models/models.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

class MonitorScreen extends StatefulWidget {
  const MonitorScreen({super.key});

  @override
  State<MonitorScreen> createState() => _MonitorScreenState();
}

class _MonitorScreenState extends State<MonitorScreen> {
  int _selectedPeriod = 1; // 0: 7 Hari, 1: 30 Hari, 2: 90 Hari

  List<HeadacheEpisode> get _filteredEpisodes {
    final now = DateTime(2026, 9, 11);
    switch (_selectedPeriod) {
      case 0:
        return MockData.headacheEpisodes
            .where((e) => e.startTime.isAfter(now.subtract(const Duration(days: 7))))
            .toList();
      case 1:
        return MockData.headacheEpisodes
            .where((e) => e.startTime.isAfter(now.subtract(const Duration(days: 30))))
            .toList();
      case 2:
        return MockData.headacheEpisodes
            .where((e) => e.startTime.isAfter(now.subtract(const Duration(days: 90))))
            .toList();
      default:
        return MockData.headacheEpisodes;
    }
  }

  String get _periodLabel {
    switch (_selectedPeriod) {
      case 0:
        return '7 Hari Terakhir';
      case 1:
        return '30 Hari Terakhir';
      case 2:
        return '3 Bulan Terakhir';
      default:
        return '30 Hari Terakhir';
    }
  }

  @override
  Widget build(BuildContext context) {
    final episodes = _filteredEpisodes;
    final avgIntensity = episodes.isNotEmpty
        ? episodes.map((e) => e.intensity).reduce((a, b) => a + b) / episodes.length
        : 0.0;
    final avgDuration = episodes.isNotEmpty
        ? Duration(
            minutes: episodes.map((e) => e.duration.inMinutes).reduce((a, b) => a + b) ~/
                episodes.length)
        : Duration.zero;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Decorative Ambient Background Orbs
          Positioned(
            top: -50,
            right: -30,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.secondary.withAlpha(35),
                    AppColors.secondary.withAlpha(0),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 180,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withAlpha(30),
                    AppColors.primary.withAlpha(0),
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

                // 2. Period Selector (Segmented Pills)
                _buildPeriodSelector(),

                const SizedBox(height: 20),

                // 3. Hero Status & Clinical Summary Banner
                _buildHeroVerdictCard(
                  episodesCount: episodes.length,
                  avgIntensity: avgIntensity,
                  avgDuration: avgDuration,
                ),

                const SizedBox(height: 20),

                // 4. 4 Redesigned Themed Metric Pods
                _buildMetricPods(
                  episodesCount: episodes.length,
                  avgIntensity: avgIntensity,
                  avgDuration: avgDuration,
                ),

                const SizedBox(height: 24),

                // 5. Interactive & Decorative Intensity Trend Chart
                _buildChartSection(episodes),

                const SizedBox(height: 24),

                // 6. Pain Location Distribution Card
                _buildLocationDistributionCard(episodes),

                const SizedBox(height: 24),

                // 7. Top Triggers Breakdown
                _buildTriggerFrequencyCard(episodes),

                const SizedBox(height: 24),

                // 8. Sleep & Hydration Correlation Card
                _buildCorrelationCard(episodes),

                const SizedBox(height: 24),

                // 9. Recent Episodes List with Enhanced Cards
                _buildRecentEpisodesSection(context, episodes),

                const SizedBox(height: 20),
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
          border: Border.all(color: AppColors.border.withAlpha(180)),
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
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2563EB), Color(0xFF0284C7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withAlpha(40),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  LucideIcons.activity,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withAlpha(15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Statistik & Tren',
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 9.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Monitor Sakit Kepala',
                    style: AppTypography.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        const Icon(
                          Icons.check_circle_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Laporan $_periodLabel berhasil diekspor.',
                          style: AppTypography.bodySmall.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                    backgroundColor: AppColors.primaryDark,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Icon(
                  LucideIcons.download,
                  size: 18,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // 2. PERIOD SELECTOR (SEGMENTED PILLS)
  // ==========================================
  Widget _buildPeriodSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowMedium,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            _buildPeriodTab(
              index: 0,
              label: '7 Hari',
              icon: LucideIcons.calendarDays,
            ),
            _buildPeriodTab(
              index: 1,
              label: '30 Hari',
              icon: LucideIcons.calendar,
            ),
            _buildPeriodTab(
              index: 2,
              label: '3 Bulan',
              icon: LucideIcons.history,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodTab({
    required int index,
    required String label,
    required IconData icon,
  }) {
    final isSelected = _selectedPeriod == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedPeriod = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 9),
          decoration: BoxDecoration(
            gradient: isSelected
                ? const LinearGradient(
                    colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.primary.withAlpha(50),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 14,
                color: isSelected ? Colors.white : AppColors.textSecondary,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: AppTypography.labelMedium.copyWith(
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================
  // 3. HERO VERDICT & PROGRESS CARD
  // ==========================================
  Widget _buildHeroVerdictCard({
    required int episodesCount,
    required double avgIntensity,
    required Duration avgDuration,
  }) {
    final isImproving = avgIntensity < 6.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withAlpha(55),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              // Background Gradient
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF0F172A),
                      Color(0xFF1E3A8A),
                      Color(0xFF2563EB),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status Badge Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(30),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withAlpha(45),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: isImproving
                                      ? const Color(0xFF4ADE80)
                                      : const Color(0xFFFBBF24),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                isImproving
                                    ? 'Tren: Pola Membaik & Terkendali'
                                    : 'Tren: Perlu Perhatian Ekstra',
                                style: AppTypography.labelSmall.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(25),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            LucideIcons.trendingDown,
                            size: 16,
                            color: Color(0xFF86EFAC),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Main Title
                    Text(
                      'Evaluasi Gejala $_periodLabel',
                      style: AppTypography.headlineMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Frekuensi nyeri stabil dengan rerata durasi ${avgDuration.inHours}h ${avgDuration.inMinutes % 60}m per episode.',
                      style: AppTypography.bodySmall.copyWith(
                        color: Colors.white.withAlpha(210),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Pain Intensity Meter Visual
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(22),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withAlpha(40),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Indeks Keparahan Nyeri',
                                style: AppTypography.labelSmall.copyWith(
                                  color: Colors.white.withAlpha(220),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFBBF24).withAlpha(40),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  'Tingkat Sedang (5.1/10)',
                                  style: AppTypography.labelSmall.copyWith(
                                    color: const Color(0xFFFDE68A),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: SizedBox(
                              height: 8,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF22C55E),
                                          Color(0xFFEAB308),
                                          Color(0xFFEF4444),
                                        ],
                                      ),
                                    ),
                                  ),
                                  FractionallySizedBox(
                                    alignment: Alignment.centerLeft,
                                    widthFactor: (avgIntensity / 10).clamp(0.0, 1.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white.withAlpha(60),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '1 Ringan',
                                style: AppTypography.labelSmall.copyWith(
                                  color: Colors.white.withAlpha(160),
                                  fontSize: 9,
                                ),
                              ),
                              Text(
                                '5 Sedang',
                                style: AppTypography.labelSmall.copyWith(
                                  color: Colors.white.withAlpha(160),
                                  fontSize: 9,
                                ),
                              ),
                              Text(
                                '10 Berat',
                                style: AppTypography.labelSmall.copyWith(
                                  color: Colors.white.withAlpha(160),
                                  fontSize: 9,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Decorative Corner Shapes
              Positioned(
                top: -25,
                right: -25,
                child: Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withAlpha(20),
                      width: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================
  // 4. 4 REDESIGNED THEMED METRIC PODS
  // ==========================================
  Widget _buildMetricPods({
    required int episodesCount,
    required double avgIntensity,
    required Duration avgDuration,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildMetricTile(
                  icon: LucideIcons.activity,
                  iconColor: const Color(0xFF2563EB),
                  bgColor: const Color(0xFFEFF6FF),
                  borderColor: const Color(0xFFBFDBFE),
                  value: '$episodesCount',
                  unit: 'Episode',
                  label: 'Total Terjadi',
                  subtext: '-25% dari periode lalu',
                  isPositive: true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricTile(
                  icon: LucideIcons.gauge,
                  iconColor: const Color(0xFFE11D48),
                  bgColor: const Color(0xFFFFF1F2),
                  borderColor: const Color(0xFFFECDD3),
                  value: avgIntensity.toStringAsFixed(1),
                  unit: '/ 10',
                  label: 'Rata-rata Nyeri',
                  subtext: 'Kategori Sedang',
                  isPositive: false,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildMetricTile(
                  icon: LucideIcons.clock,
                  iconColor: const Color(0xFF0284C7),
                  bgColor: const Color(0xFFF0F9FF),
                  borderColor: const Color(0xFFBAE6FD),
                  value: '${avgDuration.inHours}h ${avgDuration.inMinutes % 60}m',
                  unit: '',
                  label: 'Rata-rata Durasi',
                  subtext: 'Per episode nyeri',
                  isPositive: true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricTile(
                  icon: LucideIcons.sun,
                  iconColor: const Color(0xFFD97706),
                  bgColor: const Color(0xFFFFFBEB),
                  borderColor: const Color(0xFFFDE68A),
                  value: MockData.mostCommonTime,
                  unit: '',
                  label: 'Waktu Rentan',
                  subtext: '12:00 - 17:00 WIB',
                  isPositive: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricTile({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required Color borderColor,
    required String value,
    required String unit,
    required String label,
    required String subtext,
    required bool isPositive,
  }) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: borderColor),
                ),
                child: Icon(icon, size: 18, color: iconColor),
              ),
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: iconColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: AppTypography.headlineMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              if (unit.isNotEmpty) ...[
                const SizedBox(width: 4),
                Text(
                  unit,
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 2),
          Text(label, style: AppTypography.titleMedium.copyWith(fontSize: 13)),
          const SizedBox(height: 4),
          Text(
            subtext,
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.textTertiary,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // 5. INTENSITY TREND CHART
  // ==========================================
  Widget _buildChartSection(List<HeadacheEpisode> episodes) {
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
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Grafik Fluktuasi Intensitas',
                      style: AppTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Perjalanan skala nyeri tiap episode',
                      style: AppTypography.bodySmall,
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withAlpha(15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Skala 1 - 10',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Color legend row
            Row(
              children: [
                _buildChartLegend(const Color(0xFF22C55E), 'Ringan (1-3)'),
                const SizedBox(width: 14),
                _buildChartLegend(const Color(0xFFEAB308), 'Sedang (4-6)'),
                const SizedBox(width: 14),
                _buildChartLegend(const Color(0xFFEF4444), 'Berat (7-10)'),
              ],
            ),

            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: _buildChart(episodes),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartLegend(Color color, String label) {
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
        const SizedBox(width: 4),
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

  Widget _buildChart(List<HeadacheEpisode> episodes) {
    if (episodes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              LucideIcons.activity,
              size: 32,
              color: AppColors.textTertiary,
            ),
            const SizedBox(height: 8),
            Text(
              'Belum ada episode tercatat pada periode ini',
              style: AppTypography.caption,
            ),
          ],
        ),
      );
    }

    final sortedEpisodes = List<HeadacheEpisode>.from(episodes)
      ..sort((a, b) => a.startTime.compareTo(b.startTime));

    final spots = <FlSpot>[];
    for (int i = 0; i < sortedEpisodes.length; i++) {
      spots.add(FlSpot(i.toDouble(), sortedEpisodes[i].intensity.toDouble()));
    }

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 2,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: AppColors.borderLight,
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 26,
              interval: 2,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toInt()}',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textTertiary,
                    fontSize: 10,
                  ),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 26,
              getTitlesWidget: (value, meta) {
                final idx = value.toInt();
                if (idx < sortedEpisodes.length) {
                  final dt = sortedEpisodes[idx].startTime;
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      '${dt.day}/${dt.month}',
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.textTertiary,
                        fontSize: 10,
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: (spots.length - 1).toDouble(),
        minY: 0,
        maxY: 10,
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            tooltipRoundedRadius: 12,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                final idx = spot.x.toInt();
                final ep = sortedEpisodes[idx];
                return LineTooltipItem(
                  'Skala ${spot.y.toInt()}/10\n${ep.durationFormatted}',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                );
              }).toList();
            },
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            gradient: const LinearGradient(
              colors: [
                Color(0xFF06B6D4),
                Color(0xFF2563EB),
                Color(0xFF4F46E5),
              ],
            ),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                final intensity = spot.y;
                Color dotColor;
                if (intensity <= 3) {
                  dotColor = const Color(0xFF22C55E);
                } else if (intensity <= 6) {
                  dotColor = const Color(0xFFEAB308);
                } else {
                  dotColor = const Color(0xFFEF4444);
                }
                return FlDotCirclePainter(
                  radius: 4.5,
                  color: dotColor,
                  strokeWidth: 2.5,
                  strokeColor: Colors.white,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF2563EB).withAlpha(45),
                  const Color(0xFF2563EB).withAlpha(0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // 6. PAIN LOCATION DISTRIBUTION CARD
  // ==========================================
  Widget _buildLocationDistributionCard(List<HeadacheEpisode> episodes) {
    // Count locations
    final locationCounts = <String, int>{};
    for (final ep in episodes) {
      for (final loc in ep.locations) {
        final label = _locationToIndonesian(loc);
        locationCounts[label] = (locationCounts[label] ?? 0) + 1;
      }
    }

    final total = locationCounts.values.fold(0, (a, b) => a + b);
    final sortedLocations = locationCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

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
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    LucideIcons.crosshair,
                    size: 16,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Distribusi Lokasi Nyeri',
                        style: AppTypography.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Area kepala yang paling sering terasa sakit',
                        style: AppTypography.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            if (sortedLocations.isEmpty)
              Text('Tidak ada data lokasi.', style: AppTypography.caption)
            else
              Column(
                children: sortedLocations.take(4).map((entry) {
                  final percentage = total > 0 ? (entry.value / total) : 0.0;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              entry.key,
                              style: AppTypography.labelMedium.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${entry.value}x (${(percentage * 100).toInt()}%)',
                              style: AppTypography.labelSmall.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: percentage,
                            backgroundColor: AppColors.borderLight,
                            valueColor: const AlwaysStoppedAnimation(Color(0xFF2563EB)),
                            minHeight: 6,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  String _locationToIndonesian(PainLocation loc) {
    switch (loc) {
      case PainLocation.forehead:
        return 'Dahi';
      case PainLocation.temples:
        return 'Pelipis';
      case PainLocation.backOfHead:
        return 'Belakang Kepala';
      case PainLocation.aroundEyes:
        return 'Sekitar Mata';
      case PainLocation.wholeHead:
        return 'Seluruh Kepala';
      case PainLocation.neck:
        return 'Leher';
    }
  }

  // ==========================================
  // 7. TOP TRIGGERS BREAKDOWN
  // ==========================================
  Widget _buildTriggerFrequencyCard(List<HeadacheEpisode> episodes) {
    final counts = <String, int>{};
    for (final episode in episodes) {
      for (final trigger in episode.triggers) {
        final label = _triggerToIndonesian(trigger);
        counts[label] = (counts[label] ?? 0) + 1;
      }
    }

    final sortedTriggers = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

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
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF3C7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    LucideIcons.alertCircle,
                    size: 16,
                    color: Color(0xFFD97706),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pemicu Paling Signifikan',
                        style: AppTypography.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Faktor eksternal yang memicu episode',
                        style: AppTypography.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 10,
              children: sortedTriggers.take(6).map((entry) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _triggerIcon(entry.key),
                        size: 14,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        entry.key,
                        style: AppTypography.labelMedium.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withAlpha(20),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${entry.value}x',
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  IconData _triggerIcon(String trigger) {
    if (trigger.contains('Tidur')) return LucideIcons.moon;
    if (trigger.contains('Layar')) return LucideIcons.monitor;
    if (trigger.contains('Dehidrasi')) return LucideIcons.droplets;
    if (trigger.contains('Stres')) return LucideIcons.zap;
    if (trigger.contains('Makan')) return LucideIcons.utensils;
    if (trigger.contains('Kafein')) return LucideIcons.coffee;
    return LucideIcons.alertTriangle;
  }

  String _triggerToIndonesian(HeadacheTrigger t) {
    switch (t) {
      case HeadacheTrigger.lackOfSleep:
        return 'Kurang Tidur';
      case HeadacheTrigger.stress:
        return 'Stres Berlebih';
      case HeadacheTrigger.dehydration:
        return 'Dehidrasi';
      case HeadacheTrigger.screenTime:
        return 'Paparan Layar';
      case HeadacheTrigger.skippedMeal:
        return 'Telat Makan';
      case HeadacheTrigger.caffeine:
        return 'Kafein';
      case HeadacheTrigger.exercise:
        return 'Olahraga Berat';
      case HeadacheTrigger.weather:
        return 'Perubahan Cuaca';
      case HeadacheTrigger.alcohol:
        return 'Alkohol';
      case HeadacheTrigger.strongSmell:
        return 'Bau Menyengat';
    }
  }

  // ==========================================
  // 8. SLEEP & HYDRATION CORRELATION CARD
  // ==========================================
  Widget _buildCorrelationCard(List<HeadacheEpisode> episodes) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFF0FDF4), Color(0xFFDCFCE7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFBBF7D0)),
          boxShadow: [
            BoxShadow(
              color: AppColors.success.withAlpha(20),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    LucideIcons.sparkles,
                    size: 18,
                    color: Color(0xFF16A34A),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Korelasi Gaya Hidup & Nyeri',
                        style: AppTypography.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF14532D),
                        ),
                      ),
                      Text(
                        'Pola tidur dan konsumsi cairan terhadap nyeri',
                        style: AppTypography.bodySmall.copyWith(
                          color: const Color(0xFF166534),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              LucideIcons.moon,
                              size: 14,
                              color: Color(0xFF7C3AED),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Saat Nyeri Terjadi',
                              style: AppTypography.labelSmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Tidur < 5 Jam',
                          style: AppTypography.titleMedium.copyWith(
                            color: AppColors.danger,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Air: 3-4 gelas',
                          style: AppTypography.caption,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 44,
                    color: AppColors.borderLight,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.verified_rounded,
                              size: 14,
                              color: Color(0xFF16A34A),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Saat Bebas Nyeri',
                              style: AppTypography.labelSmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Tidur > 7 Jam',
                          style: AppTypography.titleMedium.copyWith(
                            color: const Color(0xFF16A34A),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Air: 7-8 gelas',
                          style: AppTypography.caption,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // 9. RECENT EPISODES SECTION
  // ==========================================
  Widget _buildRecentEpisodesSection(
    BuildContext context,
    List<HeadacheEpisode> episodes,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Episode Terbaru',
                    style: AppTypography.headlineSmall.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(20),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${episodes.length} Data',
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/history'),
                child: Row(
                  children: [
                    Text(
                      'Lihat Semua',
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
        ),
        const SizedBox(height: 14),
        ...episodes.take(3).map(
              (episode) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 4,
                ),
                child: _buildRecentEpisodeCard(context, episode),
              ),
            ),
      ],
    );
  }

  Widget _buildRecentEpisodeCard(
    BuildContext context,
    HeadacheEpisode episode,
  ) {
    Color severityColor;
    switch (episode.severity) {
      case HeadacheSeverity.mild:
        severityColor = AppColors.success;
        break;
      case HeadacheSeverity.moderate:
        severityColor = AppColors.warning;
        break;
      case HeadacheSeverity.severe:
        severityColor = AppColors.danger;
        break;
    }

    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        '/headache-detail',
        arguments: episode,
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowMedium,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: severityColor.withAlpha(20),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: severityColor.withAlpha(50)),
              ),
              child: Center(
                child: Text(
                  '${episode.intensity}',
                  style: AppTypography.headlineSmall.copyWith(
                    color: severityColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                        '${episode.startTime.day}/${episode.startTime.month}/${episode.startTime.year}',
                        style: AppTypography.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '· ${_formatTime(episode.startTime)}',
                        style: AppTypography.caption,
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${episode.durationFormatted} · ${episode.locationLabel.split(',').first}',
                    style: AppTypography.bodySmall,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: severityColor.withAlpha(18),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                episode.intensityLabel,
                style: AppTypography.labelSmall.copyWith(
                  color: severityColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              LucideIcons.chevronRight,
              size: 16,
              color: AppColors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m WIB';
  }
}
