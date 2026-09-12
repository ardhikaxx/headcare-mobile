import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../models/models.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

class HeadacheDetailScreen extends StatelessWidget {
  const HeadacheDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final episode = ModalRoute.of(context)!.settings.arguments as HeadacheEpisode;
    final color = _getColor(episode);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          children: [
            // Header
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Episode Sakit Kepala', style: AppTypography.titleLarge),
                      Text(
                        '${episode.startTime.day}/${episode.startTime.month}/${episode.startTime.year}',
                        style: AppTypography.caption,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: color.withAlpha(20),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    episode.intensityLabel,
                    style: AppTypography.labelMedium.copyWith(color: color),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Intensity Visual
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  Text('Intensitas Nyeri', style: AppTypography.labelLarge),
                  const SizedBox(height: 12),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: color.withAlpha(15),
                      shape: BoxShape.circle,
                      border: Border.all(color: color.withAlpha(40), width: 3),
                    ),
                    child: Center(
                      child: Text(
                        '${episode.intensity}',
                        style: AppTypography.displayLarge.copyWith(color: color),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Intensity bar
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: FractionallySizedBox(
                      widthFactor: episode.intensity / 10,
                      child: Container(
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('1', style: AppTypography.labelSmall),
                      Text('10', style: AppTypography.labelSmall),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Timeline
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  _TimelineItem(
                    label: 'Mulai',
                    time: _formatTime(episode.startTime),
                    icon: Icons.play_circle_outline,
                    color: AppColors.primary,
                  ),
                  Expanded(
                    child: Container(
                      height: 2,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: AppColors.border,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),
                  _TimelineItem(
                    label: 'Selesai',
                    time: episode.endTime != null ? _formatTime(episode.endTime!) : '--:--',
                    icon: Icons.stop_circle_outlined,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      episode.durationFormatted,
                      style: AppTypography.labelMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Location
            _DetailSection(
              title: 'Lokasi Nyeri',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: episode.locations.map(
                  (loc) => _Tag(label: _getLocationName(loc)),
                ).toList(),
              ),
            ),
            const SizedBox(height: 16),
            // Character
            _DetailSection(
              title: 'Karakter Nyeri',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: episode.characters.map(
                  (c) => _Tag(label: _getCharacterName(c)),
                ).toList(),
              ),
            ),
            const SizedBox(height: 16),
            // Symptoms
            if (episode.symptoms.isNotEmpty)
              _DetailSection(
                title: 'Gejala yang Menyertai',
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: episode.symptoms.map(
                    (s) => _Tag(label: s),
                  ).toList(),
                ),
              ),
            if (episode.symptoms.isNotEmpty) const SizedBox(height: 16),
            // Triggers
            if (episode.triggers.isNotEmpty)
              _DetailSection(
                title: 'Pemicu yang Tercatat',
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: episode.triggers.map(
                    (t) => _Tag(label: _getTriggerName(t)),
                  ).toList(),
                ),
              ),
            if (episode.triggers.isNotEmpty) const SizedBox(height: 16),
            // Lifestyle Factors
            _DetailSection(
              title: 'Faktor Gaya Hidup',
              child: Column(
                children: [
                  _LifestyleRow(
                    icon: LucideIcons.moon,
                    label: 'Durasi Tidur',
                    value: '${episode.sleepDuration.inHours}h ${episode.sleepDuration.inMinutes % 60}m',
                  ),
                  const SizedBox(height: 10),
                  _LifestyleRow(
                    icon: LucideIcons.droplets,
                    label: 'Asupan Air',
                    value: '${episode.waterIntakeGlasses} gelas',
                  ),
                  if (episode.activityBefore != null) ...[
                    const SizedBox(height: 10),
                    _LifestyleRow(
                      icon: LucideIcons.activity,
                      label: 'Aktivitas Sebelumnya',
                      value: episode.activityBefore!,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Medication
            if (episode.tookMedication)
              _DetailSection(
                title: 'Obat',
                child: Row(
                  children: [
                    const Icon(LucideIcons.pill, size: 18, color: AppColors.primary),
                    const SizedBox(width: 8),
                    Text(
                      episode.medicationName ?? 'Tidak ditentukan',
                      style: AppTypography.bodyMedium,
                    ),
                  ],
                ),
              ),
            if (episode.tookMedication) const SizedBox(height: 16),
            // Notes
            if (episode.notes != null)
              _DetailSection(
                title: 'Catatan',
                child: Text(
                  episode.notes!,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _getColor(HeadacheEpisode episode) {
    switch (episode.severity) {
      case HeadacheSeverity.mild:
        return AppColors.success;
      case HeadacheSeverity.moderate:
        return AppColors.warning;
      case HeadacheSeverity.severe:
        return AppColors.danger;
    }
  }

  String _formatTime(DateTime dt) {
    return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  String _getLocationName(PainLocation loc) {
    switch (loc) {
      case PainLocation.forehead: return 'Dahi';
      case PainLocation.temples: return 'Pelipis';
      case PainLocation.backOfHead: return 'Belakang Kepala';
      case PainLocation.aroundEyes: return 'Sekitar Mata';
      case PainLocation.wholeHead: return 'Seluruh Kepala';
      case PainLocation.neck: return 'Leher';
    }
  }

  String _getCharacterName(PainCharacter c) {
    switch (c) {
      case PainCharacter.throbbing: return 'Berdenyut';
      case PainCharacter.pressure: return 'Tekanan';
      case PainCharacter.sharp: return 'Tajam';
      case PainCharacter.dull: return 'Tumpul';
      case PainCharacter.pulsating: return 'Berdenyut Nadi';
    }
  }

  String _getTriggerName(HeadacheTrigger t) {
    switch (t) {
      case HeadacheTrigger.lackOfSleep: return 'Kurang Tidur';
      case HeadacheTrigger.stress: return 'Stres';
      case HeadacheTrigger.dehydration: return 'Dehidrasi';
      case HeadacheTrigger.screenTime: return 'Waktu Layar';
      case HeadacheTrigger.skippedMeal: return 'Melewatkan Makan';
      case HeadacheTrigger.caffeine: return 'Kafein';
      case HeadacheTrigger.exercise: return 'Olahraga';
      default: return t.toString().split('.').last;
    }
  }
}

class _TimelineItem extends StatelessWidget {
  final String label;
  final String time;
  final IconData icon;
  final Color color;

  const _TimelineItem({
    required this.label,
    required this.time,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(height: 4),
        Text(time, style: AppTypography.titleMedium),
        Text(label, style: AppTypography.labelSmall),
      ],
    );
  }
}

class _DetailSection extends StatelessWidget {
  final String title;
  final Widget child;

  const _DetailSection({required this.title, required this.child});

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
          Text(title, style: AppTypography.titleMedium),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;

  const _Tag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: AppTypography.labelMedium),
    );
  }
}

class _LifestyleRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _LifestyleRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.textSecondary),
        const SizedBox(width: 10),
        Text(label, style: AppTypography.bodyMedium),
        const Spacer(),
        Text(value, style: AppTypography.labelMedium),
      ],
    );
  }
}
