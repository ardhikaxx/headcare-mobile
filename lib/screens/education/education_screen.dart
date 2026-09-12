import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../widgets/widgets.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({super.key});

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  String _selectedCategory = 'All';
  String _searchQuery = '';
  final _searchController = TextEditingController();

  final _categories = [
    'All',
    'Headache Basics',
    'Sleep',
    'Hydration',
    'Lifestyle',
    'Stress',
    'Doctor Visit',
  ];

  List get _filteredArticles {
    var articles = MockData.educationArticles;
    if (_selectedCategory != 'All') {
      articles = articles.where((a) => a.category == _selectedCategory).toList();
    }
    if (_searchQuery.isNotEmpty) {
      articles = articles
          .where((a) =>
              a.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              a.summary.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
    return articles;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _getCategoryLabel(String cat) {
    switch (cat) {
      case 'All': return 'Semua';
      case 'Headache Basics': return 'Dasar Sakit Kepala';
      case 'Sleep': return 'Tidur';
      case 'Hydration': return 'Hidrasi';
      case 'Lifestyle': return 'Gaya Hidup';
      case 'Stress': return 'Stres';
      case 'Doctor Visit': return 'Kunjungan Dokter';
      default: return cat;
    }
  }

  @override
  Widget build(BuildContext context) {
    final articles = _filteredArticles;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
          children: [
            FloatingHeader(
              title: 'Edukasi Kesehatan',
              showBack: true,
            ),
            const SizedBox(height: 16),
            // Search
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari artikel...',
                prefixIcon: const Icon(Icons.search, size: 20),
                suffixIcon: _searchQuery.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                        child: const Icon(Icons.close, size: 18),
                      )
                    : null,
              ),
              onChanged: (v) => setState(() => _searchQuery = v),
            ),
            const SizedBox(height: 16),
            // Categories
            SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final isSelected = _selectedCategory == cat;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCategory = cat),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary.withAlpha(15)
                            : AppColors.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.border,
                        ),
                      ),
                      child: Text(
                        _getCategoryLabel(cat),
                        style: AppTypography.labelMedium.copyWith(
                          color: isSelected ? AppColors.primary : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            // Articles
            if (articles.isEmpty)
              _buildEmptyState()
            else
              ...articles.map(
                (article) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: EducationArticleCard(
                    title: article.title,
                    category: article.category,
                    readingTime: article.readingTimeMinutes,
                    summary: article.summary,
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/article-detail',
                      arguments: article,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: [
            Icon(
              Icons.article_outlined,
              size: 48,
              color: AppColors.textTertiary,
            ),
            const SizedBox(height: 12),
            Text(
              'Tidak ada artikel ditemukan',
              style: AppTypography.titleMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Coba sesuaikan pencarian atau filter Anda.',
              style: AppTypography.caption,
            ),
          ],
        ),
      ),
    );
  }
}
