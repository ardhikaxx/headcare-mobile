import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../data/mock_data.dart';
import '../../models/models.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

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
                Text('Notifikasi', style: AppTypography.titleLarge),
              ],
            ),
            const SizedBox(height: 20),
            ...MockData.notifications.map(
              (notification) => _NotificationItem(
                notification: notification,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final AppNotification notification;

  const _NotificationItem({required this.notification});

  IconData _getIcon() {
    switch (notification.type) {
      case NotificationType.appointment:
        return LucideIcons.calendar;
      case NotificationType.monitoring:
        return LucideIcons.activity;
      case NotificationType.education:
        return LucideIcons.bookOpen;
      case NotificationType.reminder:
        return LucideIcons.bell;
    }
  }

  Color _getColor() {
    switch (notification.type) {
      case NotificationType.appointment:
        return AppColors.primary;
      case NotificationType.monitoring:
        return AppColors.info;
      case NotificationType.education:
        return AppColors.success;
      case NotificationType.reminder:
        return AppColors.warning;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: notification.isRead
            ? AppColors.surface
            : AppColors.primary.withAlpha(8),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: notification.isRead ? AppColors.border : AppColors.primary.withAlpha(30),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _getColor().withAlpha(20),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(_getIcon(), size: 18, color: _getColor()),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        style: AppTypography.titleMedium.copyWith(
                          fontWeight: notification.isRead
                              ? FontWeight.w500
                              : FontWeight.w600,
                        ),
                      ),
                    ),
                    if (!notification.isRead)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  notification.message,
                  style: AppTypography.bodySmall,
                ),
                const SizedBox(height: 6),
                Text(
                  _formatTime(notification.dateTime),
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final now = DateTime(2026, 9, 11, 12);
    final diff = now.difference(dt);
    if (diff.inHours < 1) return '${diff.inMinutes}m lalu';
    if (diff.inHours < 24) return '${diff.inHours}j lalu';
    return '${diff.inDays}h lalu';
  }
}
