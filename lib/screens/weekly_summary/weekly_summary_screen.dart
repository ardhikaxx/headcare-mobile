import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../data/mock_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../widgets/widgets.dart';

class WeeklySummaryScreen extends StatelessWidget {
  const WeeklySummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final episodesThisWeek = MockData.episodesThisWeek;
    final episodesLastWeek = MockData.episodesLastWeek;
    final avgIntensity = MockData.averageIntensity30Days;
    final avgDuration = MockData.averageDuration30Days;
    final triggerFreq = MockData.triggerFrequency;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          children: [
            FloatingHeader(
              title: 'Ringkasan Mingguan',
              subtitle: 'Sep 4 - Sep 11, 2026',
              showBack: true,
            ),
            const SizedBox(height: 24),
            // Comparison
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Minggu Ini vs Minggu Lalu',
                    style: AppTypography.titleMedium.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _WeeklyComparison(
                        label: 'Episode',
                        thisWeek: '$episodesThisWeek',
                        lastWeek: '$episodesLastWeek',
                        isLowerBetter: true,
                      ),
                      const SizedBox(width: 16),
                      _WeeklyComparison(
                        label: 'Rata-rata Intensitas',
                        thisWeek: avgIntensity.toStringAsFixed(1),
                        lastWeek: '5.4',
                        isLowerBetter: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Summary stats
            Text('Ringkasan', style: AppTypography.titleMedium),
            const SizedBox(height: 12),
            Row(
              children: [
                _SummaryCard(
                  value: '$episodesThisWeek',
                  label: 'Total Episode',
                  color: AppColors.warning,
                ),
                const SizedBox(width: 12),
                _SummaryCard(
                  value: avgIntensity.toStringAsFixed(1),
                  label: 'Rata-rata Intensitas',
                  color: AppColors.primary,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _SummaryCard(
                  value: '${avgDuration.inHours}j ${avgDuration.inMinutes % 60}m',
                  label: 'Rata-rata Durasi',
                  color: AppColors.secondary,
                ),
                const SizedBox(width: 12),
                _SummaryCard(
                  value: '6.5j',
                  label: 'Rata-rata Tidur',
                  color: AppColors.info,
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Intensity chart
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tren Intensitas', style: AppTypography.titleMedium),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 140,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 10,
                        barGroups: List.generate(7, (i) {
                          final intensity = [4.0, 3.0, 6.0, 0.0, 5.0, 7.0, 3.0][i];
                          return BarChartGroupData(
                            x: i,
                            barRods: [
                              BarChartRodData(
                                toY: intensity,
                                color: intensity == 0
                                    ? AppColors.border
                                    : AppColors.primary,
                                width: 20,
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(4),
                                ),
                              ),
                            ],
                          );
                        }),
                        titlesData: FlTitlesData(
                          show: true,
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 24,
                              interval: 2,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  '${value.toInt()}',
                                  style: AppTypography.labelSmall.copyWith(
                                    color: AppColors.textTertiary,
                                  ),
                                );
                              },
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                final days = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
                                return Text(
                                  days[value.toInt()],
                                  style: AppTypography.labelSmall.copyWith(
                                    color: AppColors.textTertiary,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Most frequent trigger
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pemicu Paling Sering', style: AppTypography.titleMedium),
                  const SizedBox(height: 12),
                  if (triggerFreq.isNotEmpty)
                    ...triggerFreq.entries.take(3).map(
                      (entry) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(entry.key, style: AppTypography.bodyMedium),
                                  const SizedBox(height: 4),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(2),
                                    child: LinearProgressIndicator(
                                      value: entry.value / MockData.headacheEpisodes.length,
                                      backgroundColor: AppColors.border,
                                      valueColor: const AlwaysStoppedAnimation(
                                        AppColors.primary,
                                      ),
                                      minHeight: 6,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              '${entry.value}x',
                              style: AppTypography.titleMedium.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Insight
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.infoLight.withAlpha(80),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(LucideIcons.lightbulb, size: 20, color: AppColors.info),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Episode yang Anda catat menurun minggu ini dibandingkan minggu lalu. Terus lacak untuk memantau kemajuan Anda.',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
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
}

class _WeeklyComparison extends StatelessWidget {
  final String label;
  final String thisWeek;
  final String lastWeek;
  final bool isLowerBetter;

  const _WeeklyComparison({
    required this.label,
    required this.thisWeek,
    required this.lastWeek,
    required this.isLowerBetter,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTypography.labelMedium.copyWith(
              color: Colors.white.withAlpha(180),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                thisWeek,
                style: AppTypography.headlineLarge.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'vs $lastWeek',
                style: AppTypography.labelSmall.copyWith(
                  color: Colors.white.withAlpha(150),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _SummaryCard({
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.circle, size: 8, color: color),
            const SizedBox(height: 10),
            Text(value, style: AppTypography.headlineMedium),
            const SizedBox(height: 4),
            Text(label, style: AppTypography.caption),
          ],
        ),
      ),
    );
  }
}
