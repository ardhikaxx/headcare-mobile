import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../models/models.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

class AssessmentResultScreen extends StatelessWidget {
  const AssessmentResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final result = ModalRoute.of(context)!.settings.arguments as AssessmentResult;

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
                Text('Hasil Assessment', style: AppTypography.titleLarge),
              ],
            ),
            const SizedBox(height: 32),
            // Score Circle
            Center(
              child: SizedBox(
                width: 160,
                height: 160,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 160,
                      height: 160,
                      child: CircularProgressIndicator(
                        value: result.scorePercentage,
                        strokeWidth: 10,
                        backgroundColor: AppColors.border,
                        valueColor: AlwaysStoppedAnimation(
                          _getStatusColor(result.status),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${result.totalScore}/${result.maxScore}',
                          style: AppTypography.displaySmall.copyWith(
                            color: _getStatusColor(result.status),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text('dari ${result.maxScore}', style: AppTypography.caption),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Status
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: _getStatusColor(result.status).withAlpha(20),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  result.statusLabel,
                  style: AppTypography.titleMedium.copyWith(
                    color: _getStatusColor(result.status),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Summary
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Text(
                result.summary,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Contributing Patterns
            Text('Pola yang Berkontribusi', style: AppTypography.titleMedium),
            const SizedBox(height: 12),
            ...result.contributingPatterns.map(
              (pattern) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      margin: const EdgeInsets.only(top: 2),
                      decoration: BoxDecoration(
                        color: AppColors.info.withAlpha(20),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        LucideIcons.info,
                        size: 12,
                        color: AppColors.info,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(pattern, style: AppTypography.bodyMedium),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Recommended Action
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.warningLight.withAlpha(100),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        LucideIcons.alertTriangle,
                        size: 18,
                        color: AppColors.warning,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Langkah Selanjutnya yang Disarankan',
                        style: AppTypography.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    result.recommendedAction,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // CTA
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/consult'),
                icon: const Icon(LucideIcons.stethoscope, size: 18),
                label: Text(
                  'Diskusikan dengan Dokter',
                  style: AppTypography.button.copyWith(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Disclaimer
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Assessment ini hanya untuk tujuan informasi dan bukan diagnosis medis. Untuk keluhan medis, konsultasikan dengan tenaga kesehatan yang berkualitas.',
                style: AppTypography.caption,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(AssessmentStatus status) {
    switch (status) {
      case AssessmentStatus.stable:
        return AppColors.success;
      case AssessmentStatus.moderate:
        return AppColors.warning;
      case AssessmentStatus.needsAttention:
        return AppColors.danger;
    }
  }
}
