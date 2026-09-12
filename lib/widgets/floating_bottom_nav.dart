import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class FloatingBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const FloatingBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, bottomPadding + 12),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowMedium,
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            icon: LucideIcons.home,
            label: 'Beranda',
            isActive: currentIndex == 0,
            onTap: () => onTap(0),
          ),
          _NavItem(
            icon: LucideIcons.activity,
            label: 'Monitor',
            isActive: currentIndex == 1,
            onTap: () => onTap(1),
          ),
          _NavItem(
            icon: LucideIcons.stethoscope,
            label: 'Konsultasi',
            isActive: currentIndex == 2,
            onTap: () => onTap(2),
          ),
          _NavItem(
            icon: LucideIcons.user,
            label: 'Profil',
            isActive: currentIndex == 3,
            onTap: () => onTap(3),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: isActive ? 16 : 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primary.withAlpha(20)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: isActive ? AppColors.primary : AppColors.textSecondary,
            ),
            if (isActive) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
