import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../models/models.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../widgets/widgets.dart';

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({super.key});

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  int _currentQuestion = 0;
  final Map<String, int> _answers = {};

  final questions = MockData.assessmentQuestions;

  void _selectAnswer(int score) {
    setState(() {
      _answers[questions[_currentQuestion].id] = score;
    });
  }

  void _nextQuestion() {
    if (_currentQuestion < questions.length - 1) {
      setState(() => _currentQuestion++);
    } else {
      _showResult();
    }
  }

  void _prevQuestion() {
    if (_currentQuestion > 0) {
      setState(() => _currentQuestion--);
    }
  }

  void _showResult() {
    final totalScore = _answers.values.fold(0, (sum, v) => sum + v);
    final maxScore = questions.length * 4;

    AssessmentStatus status;
    String summary;
    List<String> patterns;
    String action;

    if (totalScore <= maxScore * 0.3) {
      status = AssessmentStatus.stable;
      summary =
          'Jawaban Anda menunjukkan bahwa gejala sakit kepala Anda saat ini masih dapat dikendalikan dan tidak berdampak signifikan pada aktivitas sehari-hari Anda.';
      patterns = [
        'Frekuensi episode sakit kepala rendah',
        'Dampak minimal pada aktivitas sehari-hari',
        'Gejala tampak sudah terkelola dengan baik',
      ];
      action =
          'Lanjutkan praktik perawatan diri dan pemantauan Anda saat ini. Lakukan asesmen ulang jika gejala berubah.';
    } else if (totalScore <= maxScore * 0.6) {
      status = AssessmentStatus.moderate;
      summary =
          'Jawaban Anda menunjukkan pola gejala sakit kepala sedang yang mungkin mendapat manfaat dari penyesuaian gaya hidup dan pemantauan berkelanjutan.';
      patterns = [
        'Frekuensi episode sakit kepala sedang',
        'Beberapa dampak pada aktivitas sehari-hari terdeteksi',
        'Pola pemicu yang dapat diidentifikasi hadir',
      ];
      action =
          'Fokus pada identifikasi dan pengelolaan pemicu. Pertimbangkan untuk membahas pola dengan tenaga kesehatan profesional.';
    } else {
      status = AssessmentStatus.needsAttention;
      summary =
          'Catatan sakit kepala Anda belakangan ini menunjukkan bahwa gejala Anda memengaruhi aktivitas sehari-hari lebih sering. Pertimbangkan untuk membahas pola ini dengan tenaga kesehatan profesional.';
      patterns = [
        'Episode sakit kepala sering dengan intensitas signifikan',
        'Dampak nyata pada aktivitas sehari-hari dan kualitas hidup',
        'Beberapa pemicu tumpang tindih teridentifikasi',
        'Penggunaan obat mungkin perlu ditinjau ulang',
      ];
      action =
          'Diskusikan pola ini dengan tenaga kesehatan profesional untuk mengeksplorasi strategi pengelolaan dan menyingkirkan penyebab yang mendasari.';
    }

    final result = AssessmentResult(
      id: 'AR_NEW',
      date: DateTime(2026, 9, 11),
      totalScore: totalScore,
      maxScore: maxScore,
      status: status,
      summary: summary,
      contributingPatterns: patterns,
      recommendedAction: action,
    );

    Navigator.pushReplacementNamed(
      context,
      '/assessment-result',
      arguments: result,
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[_currentQuestion];
    final selectedAnswer = _answers[question.id];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            FloatingHeader(
              title: 'Assessment Mandiri',
              subtitle: 'Pertanyaan ${_currentQuestion + 1} dari ${questions.length}',
              showBack: true,
            ),
            const SizedBox(height: 16),
            // Progress
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: (_currentQuestion + 1) / questions.length,
                  backgroundColor: AppColors.border,
                  valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                  minHeight: 4,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      question.category,
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      question.question,
                      style: AppTypography.headlineMedium,
                    ),
                    const SizedBox(height: 24),
                    ...List.generate(question.options.length, (index) {
                      final isSelected = selectedAnswer == index;
                      return GestureDetector(
                        onTap: () => _selectAnswer(index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary.withAlpha(15)
                                : AppColors.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.border,
                              width: isSelected ? 1.5 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.primary
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.primary
                                        : AppColors.border,
                                  ),
                                ),
                                child: isSelected
                                    ? const Icon(
                                        Icons.check,
                                        size: 14,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  question.options[index],
                                  style: AppTypography.bodyLarge.copyWith(
                                    color: isSelected
                                        ? AppColors.primary
                                        : AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            // Navigation
            Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(top: BorderSide(color: AppColors.borderLight)),
              ),
              child: Row(
                children: [
                  if (_currentQuestion > 0)
                    Expanded(
                      child: SecondaryButton(
                        label: 'Kembali',
                        onPressed: _prevQuestion,
                        isExpanded: true,
                      ),
                    ),
                  if (_currentQuestion > 0) const SizedBox(width: 12),
                  Expanded(
                    child: PrimaryButton(
                      label: _currentQuestion == questions.length - 1
                          ? 'Lihat Hasil'
                          : 'Lanjut',
                      onPressed: selectedAnswer != null ? _nextQuestion : null,
                      isExpanded: true,
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
