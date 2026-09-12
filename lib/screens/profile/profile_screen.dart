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
    final totalEpisodes = MockData.headacheEpisodes.length;
    final totalConsultations = MockData.consultationHistory.length;
    final totalAssessments = MockData.assessmentResults.length;

    final heightInMeters = patient.height / 100.0;
    final bmi = (patient.weight / (heightInMeters * heightInMeters)).toStringAsFixed(1);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Ambient Decorative Background Orbs
          Positioned(
            top: -60,
            left: -40,
            child: Container(
              width: 230,
              height: 230,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primaryLight.withAlpha(35),
                    AppColors.primaryLight.withAlpha(0),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 180,
            right: -50,
            child: Container(
              width: 210,
              height: 210,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF06B6D4).withAlpha(30),
                    const Color(0xFF06B6D4).withAlpha(0),
                  ],
                ),
              ),
            ),
          ),

          // Main Scrollable Body
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 120),
              children: [
                const SizedBox(height: 12),

                // 1. Decorative Header Bar
                _buildHeaderBar(context),

                const SizedBox(height: 18),

                // 2. Digital Patient Card (Hero)
                _buildDigitalPatientCard(patient, bmi),

                const SizedBox(height: 20),

                // 3. Clinical Activity Summary Strip
                _buildActivitySummaryStrip(
                  totalEpisodes: totalEpisodes,
                  totalConsultations: totalConsultations,
                  totalAssessments: totalAssessments,
                ),

                const SizedBox(height: 22),

                // 4. Clinical Details & Emergency Contact Card
                _buildClinicalDetailsCard(patient),

                const SizedBox(height: 24),

                // 5. Grouped Settings & Preferences Menu
                _buildSettingsSection(context),

                const SizedBox(height: 20),

                // 6. Sign Out Button
                _buildSignOutButton(context),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // 1. DECORATIVE HEADER BAR
  // ==========================================
  Widget _buildHeaderBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.surface.withAlpha(235),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.border.withAlpha(180)),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowMedium,
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2563EB), Color(0xFF0284C7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withAlpha(40),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  LucideIcons.userCheck,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withAlpha(15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Rekam Medis Digital',
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 9.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Profil Pengguna',
                    style: AppTypography.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/notifications'),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Icon(
                  LucideIcons.bell,
                  size: 18,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // 2. DIGITAL PATIENT CARD (HERO)
  // ==========================================
  Widget _buildDigitalPatientCard(dynamic patient, String bmi) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1E3A8A).withAlpha(55),
              blurRadius: 22,
              offset: const Offset(0, 9),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(26),
          child: Stack(
            children: [
              // Deep Gradient Card Background
              Container(
                padding: const EdgeInsets.all(22),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF0F172A),
                      Color(0xFF1E3A8A),
                      Color(0xFF2563EB),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Card Top Row: Patient ID & Certified Badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(30),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withAlpha(50),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.verified_rounded,
                                size: 13,
                                color: Color(0xFF4ADE80),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'ID: ${patient.id} · Terverifikasi',
                                style: AppTypography.labelSmall.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'HeadCare Member',
                          style: AppTypography.labelSmall.copyWith(
                            color: Colors.white.withAlpha(190),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // Avatar & Basic Info
                    Row(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF38BDF8), Color(0xFF2563EB)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withAlpha(40),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  patient.initials,
                                  style: AppTypography.displaySmall.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                color: const Color(0xFF22C55E),
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                patient.name,
                                style: AppTypography.headlineMedium.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${patient.age} Tahun · ${patient.gender}',
                                style: AppTypography.bodySmall.copyWith(
                                  color: Colors.white.withAlpha(220),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                patient.email,
                                style: AppTypography.labelSmall.copyWith(
                                  color: Colors.white.withAlpha(180),
                                  fontSize: 10.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // 4 Glassmorphic Physical Health Metrics
                    Row(
                      children: [
                        Expanded(
                          child: _buildGlassMetricPod(
                            icon: LucideIcons.droplets,
                            iconColor: const Color(0xFFFDA4AF),
                            label: 'Gol. Darah',
                            value: patient.bloodType,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildGlassMetricPod(
                            icon: LucideIcons.scale,
                            iconColor: const Color(0xFFBAE6FD),
                            label: 'Berat Badan',
                            value: '${patient.weight.toInt()} kg',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildGlassMetricPod(
                            icon: LucideIcons.ruler,
                            iconColor: const Color(0xFFFDE68A),
                            label: 'Tinggi Badan',
                            value: '${patient.height.toInt()} cm',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildGlassMetricPod(
                            icon: LucideIcons.activity,
                            iconColor: const Color(0xFF86EFAC),
                            label: 'Indeks BMI',
                            value: '$bmi (Ideal)',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Decorative Translucent Circular Rings
              Positioned(
                top: -30,
                right: -30,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withAlpha(20),
                      width: 22,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGlassMetricPod({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(25),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withAlpha(40),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, size: 14, color: iconColor),
          const SizedBox(height: 5),
          Text(
            value,
            style: AppTypography.labelMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTypography.caption.copyWith(
              color: Colors.white.withAlpha(180),
              fontSize: 9,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // ==========================================
  // 3. CLINICAL ACTIVITY SUMMARY STRIP
  // ==========================================
  Widget _buildActivitySummaryStrip({
    required int totalEpisodes,
    required int totalConsultations,
    required int totalAssessments,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowMedium,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildActivityItem(
              icon: LucideIcons.calendar,
              iconColor: AppColors.primary,
              value: '$totalEpisodes',
              label: 'Episode Dicatat',
            ),
            Container(width: 1, height: 36, color: AppColors.borderLight),
            _buildActivityItem(
              icon: LucideIcons.stethoscope,
              iconColor: const Color(0xFF7C3AED),
              value: '$totalConsultations',
              label: 'Konsultasi Selesai',
            ),
            Container(width: 1, height: 36, color: AppColors.borderLight),
            _buildActivityItem(
              icon: LucideIcons.clipboardCheck,
              iconColor: const Color(0xFF059669),
              value: '$totalAssessments',
              label: 'Asesmen Diri',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: iconColor),
            const SizedBox(width: 5),
            Text(
              value,
              style: AppTypography.titleMedium.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: AppTypography.caption.copyWith(
            color: AppColors.textSecondary,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  // ==========================================
  // 4. CLINICAL DETAILS CARD
  // ==========================================
  Widget _buildClinicalDetailsCard(dynamic patient) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowMedium,
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    LucideIcons.fileHeart,
                    size: 16,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Catatan Medis & Kontak Darurat',
                  style: AppTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Alergi
            _buildDetailRow(
              icon: Icons.shield_outlined,
              iconColor: const Color(0xFF10B981),
              title: 'Riwayat Alergi',
              value: patient.allergies.isNotEmpty
                  ? patient.allergies.join(', ')
                  : 'Tidak ada alergi yang diketahui',
            ),

            const Divider(height: 20, color: AppColors.borderLight),

            // Obat Rutin
            _buildDetailRow(
              icon: LucideIcons.pill,
              iconColor: const Color(0xFF0284C7),
              title: 'Obat yang Dikonsumsi',
              value: patient.currentMedications.isNotEmpty
                  ? patient.currentMedications.join(', ')
                  : 'Tidak ada obat rutin',
            ),

            const Divider(height: 20, color: AppColors.borderLight),

            // Kontak Darurat
            _buildDetailRow(
              icon: LucideIcons.phoneCall,
              iconColor: const Color(0xFFE11D48),
              title: 'Kontak Darurat (Keluarga)',
              value: '${patient.emergencyContact} · ${patient.emergencyPhone}',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: iconColor.withAlpha(20),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 16, color: iconColor),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: AppTypography.labelMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ==========================================
  // 5. GROUPED SETTINGS MENU
  // ==========================================
  Widget _buildSettingsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pengaturan Akun & Layanan',
            style: AppTypography.headlineSmall.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowMedium,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildMenuItem(
                  icon: LucideIcons.userCog,
                  iconColor: const Color(0xFF2563EB),
                  title: 'Informasi Akun Pribadi',
                  subtitle: 'Nama, telepon, dan alamat email',
                  onTap: () {},
                ),
                const Divider(height: 1, indent: 56, color: AppColors.borderLight),
                _buildMenuItem(
                  icon: LucideIcons.bell,
                  iconColor: const Color(0xFFD97706),
                  title: 'Pengaturan Notifikasi & Pengingat',
                  subtitle: 'Jadwal check-in harian & obat',
                  onTap: () => Navigator.pushNamed(context, '/notifications'),
                ),
                const Divider(height: 1, indent: 56, color: AppColors.borderLight),
                _buildMenuItem(
                  icon: LucideIcons.shieldCheck,
                  iconColor: const Color(0xFF059669),
                  title: 'Privasi & Keamanan Data Medis',
                  subtitle: 'Enkripsi data klinis & rekam medis',
                  onTap: () {},
                ),
                const Divider(height: 1, indent: 56, color: AppColors.borderLight),
                _buildMenuItem(
                  icon: LucideIcons.helpCircle,
                  iconColor: const Color(0xFF7C3AED),
                  title: 'Pusat Bantuan & FAQ',
                  subtitle: 'Panduan penggunaan aplikasi HeadCare',
                  onTap: () {},
                ),
                const Divider(height: 1, indent: 56, color: AppColors.borderLight),
                _buildMenuItem(
                  icon: LucideIcons.info,
                  iconColor: const Color(0xFF64748B),
                  title: 'Tentang Aplikasi HeadCare',
                  subtitle: 'Versi 1.0.0+1 (Prototipe Mandiri)',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: iconColor.withAlpha(20),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, size: 18, color: iconColor),
      ),
      title: Text(
        title,
        style: AppTypography.labelMedium.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppTypography.caption.copyWith(fontSize: 10.5),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        size: 20,
        color: AppColors.textTertiary,
      ),
      onTap: onTap,
    );
  }

  // ==========================================
  // 6. SIGN OUT BUTTON
  // ==========================================
  Widget _buildSignOutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Row(
                children: [
                  const Icon(
                    LucideIcons.logOut,
                    color: AppColors.danger,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Keluar Akun',
                    style: AppTypography.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              content: Text(
                'Apakah Anda yakin ingin keluar dari sesi aplikasi HeadCare?',
                style: AppTypography.bodySmall,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text(
                    'Batal',
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    Navigator.pushReplacementNamed(context, '/splash');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.danger,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Keluar',
                    style: AppTypography.labelMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF2F2),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFFECACA)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                LucideIcons.logOut,
                size: 16,
                color: AppColors.danger,
              ),
              const SizedBox(width: 8),
              Text(
                'Keluar dari Aplikasi',
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.danger,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
