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
  int _selectedPeriod = 1;

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
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 100),
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('Monitor', style: AppTypography.displaySmall),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Pantau pola sakit kepala Anda dari waktu ke waktu',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Period Selector
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    _PeriodButton(
                      label: '7 Hari',
                      isSelected: _selectedPeriod == 0,
                      onTap: () => setState(() => _selectedPeriod = 0),
                    ),
                    _PeriodButton(
                      label: '30 Hari',
                      isSelected: _selectedPeriod == 1,
                      onTap: () => setState(() => _selectedPeriod = 1),
                    ),
                    _PeriodButton(
                      label: '3 Bulan',
                      isSelected: _selectedPeriod == 2,
                      onTap: () => setState(() => _selectedPeriod = 2),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Stats Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      value: '${episodes.length}',
                      label: 'Episode',
                      icon: LucideIcons.activity,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      value: avgIntensity.toStringAsFixed(1),
                      label: 'Rata-rata Intensitas',
                      icon: LucideIcons.gauge,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      value: '${avgDuration.inHours}h ${avgDuration.inMinutes % 60}m',
                      label: 'Rata-rata Durasi',
                      icon: LucideIcons.clock,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      value: MockData.mostCommonTime,
                      label: 'Paling Sering',
                      icon: LucideIcons.sun,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Chart
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Intensitas dari Waktu ke Waktu', style: AppTypography.titleMedium),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 180,
                      child: _buildChart(episodes),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Common Triggers
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pemicu Umum', style: AppTypography.titleMedium),
                    const SizedBox(height: 4),
                    Text(
                      'Pemicu yang paling sering tercatat',
                      style: AppTypography.caption,
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: MockData.triggerFrequency.entries.take(6).map(
                        (entry) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  entry.key,
                                  style: AppTypography.labelMedium,
                                ),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withAlpha(15),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '${entry.value}',
                                    style: AppTypography.labelSmall.copyWith(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Recent Episodes
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Episode Terbaru', style: AppTypography.titleMedium),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/history'),
                    child: Text(
                      'Lihat semua',
                      style: AppTypography.labelMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            ...episodes.take(3).map(
              (episode) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 4,
                ),
                child: _RecentEpisodeCard(episode: episode),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChart(List<HeadacheEpisode> episodes) {
    if (episodes.isEmpty) {
      return Center(
        child: Text('Tidak ada data', style: AppTypography.caption),
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
              reservedSize: 28,
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
              reservedSize: 24,
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
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: AppColors.primary,
            barWidth: 2.5,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: AppColors.primary,
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              color: AppColors.primary.withAlpha(20),
            ),
          ),
        ],
      ),
    );
  }
}

class _PeriodButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _PeriodButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            style: AppTypography.labelMedium.copyWith(
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const _StatCard({
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(height: 10),
          Text(value, style: AppTypography.headlineMedium),
          const SizedBox(height: 2),
          Text(label, style: AppTypography.caption),
        ],
      ),
    );
  }
}

class _RecentEpisodeCard extends StatelessWidget {
  final HeadacheEpisode episode;

  const _RecentEpisodeCard({required this.episode});

  Color get _color {
    switch (episode.severity) {
      case HeadacheSeverity.mild:
        return AppColors.success;
      case HeadacheSeverity.moderate:
        return AppColors.warning;
      case HeadacheSeverity.severe:
        return AppColors.danger;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        '/headache-detail',
        arguments: episode,
      ),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: _color.withAlpha(20),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  '${episode.intensity}',
                  style: AppTypography.titleMedium.copyWith(color: _color),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${episode.startTime.day}/${episode.startTime.month}/${episode.startTime.year}',
                    style: AppTypography.labelMedium,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${episode.durationFormatted} · ${episode.locationLabel.split(',').first}',
                    style: AppTypography.caption,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _color.withAlpha(20),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                episode.intensityLabel,
                style: AppTypography.labelSmall.copyWith(color: _color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
