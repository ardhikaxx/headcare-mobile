import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                Text('Darurat & Keamanan', style: AppTypography.titleLarge),
              ],
            ),
            const SizedBox(height: 24),
            // Warning banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.dangerLight.withAlpha(100),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.danger.withAlpha(40)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    size: 24,
                    color: AppColors.danger,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Informasi Keamanan Penting',
                          style: AppTypography.titleMedium.copyWith(
                            color: AppColors.danger,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'HeadCare bukan pengganti layanan gawat darurat medis.',
                          style: AppTypography.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text('Segera Dapatkan Pertolongan Medis Jika Anda Mengalami:',
              style: AppTypography.headlineSmall),
            const SizedBox(height: 16),
            _RedFlagItem(
              icon: Icons.bolt,
              title: 'Sakit kepala mendadak dan hebat',
              description:
                  'Sakit kepala yang muncul tiba-tiba dan sangat hebat ("sakit kepala petir") memerlukan evaluasi medis segera.',
            ),
            _RedFlagItem(
              icon: Icons.medical_services,
              title: 'Sakit kepala setelah cedera kepala',
              description:
                  'Setiap sakit kepala yang terjadi setelah benturan pada kepala atau kecelakaan harus segera dievaluasi oleh tenaga kesehatan.',
            ),
            _RedFlagItem(
              icon: Icons.accessibility_new,
              title: 'Kelemahan pada satu sisi tubuh',
              description:
                  'Kelemahan atau kebas mendadak pada satu sisi tubuh, wajah, atau anggota gerak yang disertai sakit kepala memerlukan evaluasi mendesak.',
            ),
            _RedFlagItem(
              icon: Icons.record_voice_over,
              title: 'Kesulitan berbicara atau memahami',
              description:
                  'Kesulitan berbicara, menemukan kata, atau memahami bahasa yang disertai sakit kepala memerlukan perhatian segera.',
            ),
            _RedFlagItem(
              icon: Icons.psychology_alt,
              title: 'Kebingungan atau perubahan kesadaran',
              description:
                  'Merasa bingung tidak biasa, orientasi terganggu, atau kehilangan kesadaran yang disertai sakit kepala merupakan keadaan darurat medis.',
            ),
            _RedFlagItem(
              icon: Icons.remove_red_eye,
              title: 'Perubahan penglihatan baru atau berat',
              description:
                  'Pandangan ganda mendadak, penglihatan kabur, atau kehilangan penglihatan yang disertai sakit kepala memerlukan evaluasi mendesak.',
            ),
            _RedFlagItem(
              icon: Icons.thermostat,
              title: 'Demam dengan leher kaku',
              description:
                  'Demam tinggi yang disertai sakit kepala hebat dan leher kaku dapat mengindikasikan infeksi serius yang memerlukan penanganan segera.',
            ),
            const SizedBox(height: 24),
            // Emergency CTA
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.phone, size: 18),
                label: Text(
                  'Cari Pertolongan Darurat',
                  style: AppTypography.button.copyWith(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.danger,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'HeadCare adalah prototipe pemantauan mandiri dan telekonsultasi. Halaman ini menyediakan informasi keamanan umum dan bukan pengganti saran medis profesional. Selalu konsultasikan ke tenaga kesehatan yang memenuhi syarat untuk masalah medis.',
                style: AppTypography.caption,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RedFlagItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _RedFlagItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.dangerLight.withAlpha(100),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: AppColors.danger),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: AppTypography.bodySmall,
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
