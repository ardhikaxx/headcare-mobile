import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../data/mock_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final patient = MockData.patient;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
          children: [
            Text('Profil', style: AppTypography.displaySmall),
            const SizedBox(height: 24),
            // Avatar and name
            Center(
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(20),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        patient.initials,
                        style: AppTypography.displaySmall.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(patient.name, style: AppTypography.headlineLarge),
                  const SizedBox(height: 4),
                  Text(
                    '${patient.age} tahun · ${patient.gender}',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Health Info Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Informasi Kesehatan', style: AppTypography.titleMedium),
                  const SizedBox(height: 12),
                  _HealthRow(label: 'Golongan Darah', value: patient.bloodType),
                  _HealthRow(
                    label: 'Berat Badan',
                    value: '${patient.weight} kg',
                  ),
                  _HealthRow(
                    label: 'Tinggi Badan',
                    value: '${patient.height} cm',
                  ),
                  _HealthRow(
                    label: 'Alergi',
                    value: patient.allergies.join(', '),
                  ),
                  _HealthRow(
                    label: 'Obat Saat Ini',
                    value: patient.currentMedications.join(', '),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Emergency Contact
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Kontak Darurat', style: AppTypography.titleMedium),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(
                        Icons.person_outline,
                        size: 18,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        patient.emergencyContact,
                        style: AppTypography.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.phone_outlined,
                        size: 18,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        patient.emergencyPhone,
                        style: AppTypography.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Settings menu
            _MenuSection(
              items: [
                _MenuItem(
                  icon: LucideIcons.userCog,
                  title: 'Informasi Pribadi',
                  onTap: () {},
                ),
                _MenuItem(
                  icon: LucideIcons.heart,
                  title: 'Preferensi Kesehatan',
                  onTap: () {},
                ),
                _MenuItem(
                  icon: LucideIcons.bell,
                  title: 'Pengaturan Notifikasi',
                  onTap: () {},
                ),
                _MenuItem(
                  icon: LucideIcons.shield,
                  title: 'Privasi',
                  onTap: () {},
                ),
                _MenuItem(
                  icon: LucideIcons.helpCircle,
                  title: 'Pusat Bantuan',
                  onTap: () {},
                ),
                _MenuItem(
                  icon: LucideIcons.info,
                  title: 'Tentang HeadCare',
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HealthRow extends StatelessWidget {
  final String label;
  final String value;

  const _HealthRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: AppTypography.bodyMedium),
          ),
          Text(value, style: AppTypography.labelMedium),
        ],
      ),
    );
  }
}

class _MenuSection extends StatelessWidget {
  final List<_MenuItem> items;

  const _MenuSection({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: items.asMap().entries.map(
          (entry) {
            final item = entry.value;
            final isLast = entry.key == items.length - 1;
            return Column(
              children: [
                ListTile(
                  leading: Icon(item.icon, size: 20, color: AppColors.textSecondary),
                  title: Text(item.title, style: AppTypography.bodyLarge),
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    size: 20,
                    color: AppColors.textTertiary,
                  ),
                  onTap: item.onTap,
                ),
                if (!isLast)
                  const Divider(
                    height: 1,
                    indent: 52,
                    color: AppColors.borderLight,
                  ),
              ],
            );
          },
        ).toList(),
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}
