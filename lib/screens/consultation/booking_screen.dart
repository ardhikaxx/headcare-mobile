import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../data/mock_data.dart';
import '../../models/models.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String? _selectedSlot;
  ConsultationType _consultationType = ConsultationType.video;
  bool _shareSummary = true;
  @override
  Widget build(BuildContext context) {
    final doctor = ModalRoute.of(context)!.settings.arguments as Doctor;

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
                Text('Janji Konsultasi', style: AppTypography.titleLarge),
              ],
            ),
            const SizedBox(height: 24),
            // Doctor summary
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(20),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Text(
                        doctor.name.split(' ').last[0],
                        style: AppTypography.headlineMedium.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(doctor.name, style: AppTypography.titleMedium),
                        Text(
                          '${doctor.title} · ${doctor.specialty}',
                          style: AppTypography.caption,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Rp ${doctor.consultationFee.toStringAsFixed(0)}',
                    style: AppTypography.titleMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Consultation Type
            Text('Tipe Konsultasi', style: AppTypography.titleMedium),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(
                      () => _consultationType = ConsultationType.video,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _consultationType == ConsultationType.video
                            ? AppColors.primary.withAlpha(15)
                            : AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _consultationType == ConsultationType.video
                              ? AppColors.primary
                              : AppColors.border,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            LucideIcons.video,
                            size: 18,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Video Call',
                            style: AppTypography.labelLarge.copyWith(
                              color: _consultationType == ConsultationType.video
                                  ? AppColors.primary
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(
                      () => _consultationType = ConsultationType.chat,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _consultationType == ConsultationType.chat
                            ? AppColors.primary.withAlpha(15)
                            : AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _consultationType == ConsultationType.chat
                              ? AppColors.primary
                              : AppColors.border,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            LucideIcons.messageSquare,
                            size: 18,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Chat',
                            style: AppTypography.labelLarge.copyWith(
                              color: _consultationType == ConsultationType.chat
                                  ? AppColors.primary
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Select Schedule
            Text('Pilih Jadwal', style: AppTypography.titleMedium),
            const SizedBox(height: 12),
            ...doctor.availableSlots.map(
              (slot) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: GestureDetector(
                  onTap: () => setState(() => _selectedSlot = slot),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: _selectedSlot == slot
                          ? AppColors.primary.withAlpha(15)
                          : AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _selectedSlot == slot
                            ? AppColors.primary
                            : AppColors.border,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _selectedSlot == slot
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          size: 20,
                          color: _selectedSlot == slot
                              ? AppColors.primary
                              : AppColors.textSecondary,
                        ),
                        const SizedBox(width: 12),
                        Text(slot, style: AppTypography.bodyLarge),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Chief Complaint
            Text('Keluhan Utama', style: AppTypography.titleMedium),
            const SizedBox(height: 12),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Jelaskan secara singkat keluhan utama Anda...',
              ),
              maxLines: 3,
              onChanged: (v) {},
            ),
            const SizedBox(height: 24),
            // Share Summary
            GestureDetector(
              onTap: () => setState(() => _shareSummary = !_shareSummary),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _shareSummary
                      ? AppColors.primary.withAlpha(10)
                      : AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _shareSummary
                        ? AppColors.primary.withAlpha(40)
                        : AppColors.border,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _shareSummary
                          ? Icons.check_box_rounded
                          : Icons.check_box_outline_blank_rounded,
                      color: _shareSummary ? AppColors.primary : AppColors.textSecondary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bagikan ringkasan sakit kepala dengan dokter',
                            style: AppTypography.labelLarge,
                          ),
                          if (_shareSummary) ...[
                            const SizedBox(height: 8),
                            _SummaryItem(
                              text:
                                  '${MockData.headacheEpisodes.length} episode sakit kepala dalam 30 hari terakhir',
                            ),
                            _SummaryItem(
                              text:
                                  'Rata-rata intensitas ${MockData.averageIntensity30Days.toStringAsFixed(1)}/10',
                            ),
                            _SummaryItem(
                              text:
                                  'Pemicu paling sering: Kurang Tidur',
                            ),
                            _SummaryItem(
                              text:
                                  'Assessment terbaru: Perlu Perhatian',
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Booking Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _selectedSlot != null
                    ? () => Navigator.pushNamed(
                        context, '/booking-confirmation',
                        arguments: {
                          'doctor': doctor,
                          'slot': _selectedSlot,
                          'type': _consultationType,
                        })
                    : null,
                icon: const Icon(LucideIcons.calendarCheck, size: 18),
                label: Text(
                  'Konfirmasi Janji',
                  style: AppTypography.button.copyWith(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: AppColors.primary.withAlpha(80),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String text;

  const _SummaryItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 4, color: AppColors.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text, style: AppTypography.bodySmall),
          ),
        ],
      ),
    );
  }
}
