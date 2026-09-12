import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/models.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'common_widgets.dart';

class HeadacheEpisodeCard extends StatelessWidget {
  final HeadacheEpisode episode;
  final VoidCallback? onTap;

  const HeadacheEpisodeCard({
    super.key,
    required this.episode,
    this.onTap,
  });

  Color get _severityColor {
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
      onTap: onTap,
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
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _severityColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      '${episode.intensity}',
                      style: AppTypography.titleMedium.copyWith(
                        color: _severityColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _formatDate(episode.startTime),
                        style: AppTypography.titleMedium,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${_formatTime(episode.startTime)} - ${_formatTime(episode.endTime)}',
                        style: AppTypography.caption,
                      ),
                    ],
                  ),
                ),
                StatusBadge(
                  label: episode.intensityLabel,
                  color: _severityColor,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _InfoChip(
                  icon: LucideIcons.clock,
                  label: episode.durationFormatted,
                ),
                const SizedBox(width: 8),
                _InfoChip(
                  icon: LucideIcons.mapPin,
                  label: episode.locationLabel.split(',').first,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime dt) {
    final months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
    ];
    return '${months[dt.month]} ${dt.day}, ${dt.year}';
  }

  String _formatTime(DateTime? dt) {
    if (dt == null) return '--:--';
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(label, style: AppTypography.labelSmall),
      ],
    );
  }
}


