import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../widgets/widgets.dart';

class ConsultScreen extends StatelessWidget {
  const ConsultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
          children: [
            Text('Konsultasi', style: AppTypography.displaySmall),
            const SizedBox(height: 4),
            Text(
              'Terhubung dengan tenaga kesehatan',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            // Upcoming appointment
            if (MockData.consultationHistory.isNotEmpty) ...[
              Text('Mendatang', style: AppTypography.titleMedium),
              const SizedBox(height: 12),
              AppointmentCard(
                doctorName: 'dr. Nadia Pratama, Sp.N',
                specialty: 'Neurologist',
                dateTime: DateTime(2026, 9, 12, 19, 30),
                type: 'Video Call',
                onTap: () => Navigator.pushNamed(context, '/consultation-room'),
              ),
              const SizedBox(height: 24),
            ],
            // Consultation History
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Riwayat Konsultasi', style: AppTypography.titleMedium),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/consultation-history',
                  ),
                  child: Text(
                    'Lihat semua',
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...MockData.consultationHistory.take(2).map(
              (c) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _ConsultationHistoryCard(
                  doctorName: c.doctorName,
                  dateTime: c.dateTime,
                  complaint: c.chiefComplaint ?? '',
                  status: c.status.name,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Available Doctors
            Text('Dokter Tersedia', style: AppTypography.titleMedium),
            const SizedBox(height: 4),
            Text(
              'Spesialis sakit kepala & neurologi',
              style: AppTypography.caption,
            ),
            const SizedBox(height: 12),
            ...MockData.doctors.map(
              (doctor) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: DoctorCard(
                  name: doctor.name,
                  title: doctor.title,
                  specialty: doctor.specialty,
                  rating: doctor.rating,
                  reviewCount: doctor.reviewCount,
                  fee: doctor.consultationFee,
                  isAvailable: doctor.isAvailableToday,
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/doctor-detail',
                    arguments: doctor,
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

class _ConsultationHistoryCard extends StatelessWidget {
  final String doctorName;
  final DateTime dateTime;
  final String complaint;
  final String status;

  const _ConsultationHistoryCard({
    required this.doctorName,
    required this.dateTime,
    required this.complaint,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Ags', 'Sep', 'Okt', 'Nov', 'Des'
    ];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.videocam_rounded,
              color: AppColors.primary,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(doctorName, style: AppTypography.labelMedium),
                const SizedBox(height: 2),
                Text(
                  '${months[dateTime.month]} ${dateTime.day}, ${dateTime.year} · $complaint',
                  style: AppTypography.caption,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.successLight.withAlpha(100),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Selesai',
              style: AppTypography.labelSmall.copyWith(color: AppColors.success),
            ),
          ),
        ],
      ),
    );
  }
}
