import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../models/models.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../widgets/widgets.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _filter = 'Semua';

  List<HeadacheEpisode> get _filteredEpisodes {
    switch (_filter) {
      case 'Ringan':
        return MockData.headacheEpisodes
            .where((e) => e.severity == HeadacheSeverity.mild)
            .toList();
      case 'Sedang':
        return MockData.headacheEpisodes
            .where((e) => e.severity == HeadacheSeverity.moderate)
            .toList();
      case 'Berat':
        return MockData.headacheEpisodes
            .where((e) => e.severity == HeadacheSeverity.severe)
            .toList();
      default:
        return MockData.headacheEpisodes;
    }
  }

  @override
  Widget build(BuildContext context) {
    final episodes = _filteredEpisodes;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            FloatingHeader(
              title: 'Riwayat Sakit Kepala',
              showBack: true,
              trailing: Text(
                '${MockData.headacheEpisodes.length} episode',
                style: AppTypography.caption,
              ),
            ),
            const SizedBox(height: 16),
            // Filter chips
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: ['Semua', 'Ringan', 'Sedang', 'Berat'].map(
                  (filter) {
                    final isSelected = _filter == filter;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () => setState(() => _filter = filter),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary.withAlpha(15)
                                : AppColors.surface,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.border,
                            ),
                          ),
                          child: Text(
                            filter,
                            style: AppTypography.labelMedium.copyWith(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: episodes.isEmpty
                  ? _buildEmptyState()
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 4,
                      ),
                      itemCount: episodes.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final episode = episodes[index];
                        return HeadacheEpisodeCard(
                          episode: episode,
                          onTap: () => Navigator.pushNamed(
                            context,
                            '/headache-detail',
                            arguments: episode,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 48,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: 12),
          Text(
            'Tidak ada episode ditemukan',
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Tidak ada episode sakit kepala yang sesuai dengan filter yang dipilih.',
            style: AppTypography.caption,
          ),
        ],
      ),
    );
  }
}
