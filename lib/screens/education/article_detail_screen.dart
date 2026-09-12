import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../models/models.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final article = ModalRoute.of(context)!.settings.arguments as EducationArticle;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          children: [
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
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      article.category,
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      LucideIcons.clock,
                      size: 14,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${article.readingTimeMinutes} mnt baca',
                      style: AppTypography.labelSmall,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(article.title, style: AppTypography.headlineLarge),
            const SizedBox(height: 24),
            // Article content
            Text(
              article.content,
              style: AppTypography.bodyLarge.copyWith(
                height: 1.8,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
