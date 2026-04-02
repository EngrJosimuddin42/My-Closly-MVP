import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import 'notifications_controller.dart';

class NotificationsScreen extends GetView<NotificationsController> {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // ── AppBar ─────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: Get.back,
                    child: const Icon(Icons.arrow_back_ios_new,
                        size: 18, color: AppColors.textPrimary),
                  ),
                  const Spacer(),
                  Text('Notifications', style: AppTextStyles.headlineSmall),
                  const Spacer(),
                  GestureDetector(
                    onTap: controller.markAllRead,
                    child: Text(
                      'Mark all',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: const Color(0xFF4A90D9),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ── List ───────────────────────────────────────────────
            Expanded(
              child: Obx(() {
                final newNotifs = controller.notifications
                    .where((n) => !n.isRead)
                    .toList();
                final oldNotifs = controller.notifications
                    .where((n) => n.isRead)
                    .toList();

                return ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    // NEW section
                    if (newNotifs.isNotEmpty) ...[
                      _SectionHeader(
                          label: 'NEW (${newNotifs.length})'),
                      ...newNotifs.map((n) => _NotifTile(
                          item: n,
                          onTap: () => controller.markRead(n.id))),
                    ],

                    // EARLIER section
                    if (oldNotifs.isNotEmpty) ...[
                      if (newNotifs.isNotEmpty)
                        const SizedBox(height: 8),
                      _SectionHeader(label: 'EARLIER'),
                      ...oldNotifs.map((n) => _NotifTile(
                          item: n,
                          onTap: () => controller.markRead(n.id))),
                    ],

                    // If no unread and no read → show all
                    if (newNotifs.isEmpty && oldNotifs.isEmpty)
                      _SectionHeader(
                          label: 'NEW (${controller.newCount})'),
                    if (newNotifs.isEmpty && oldNotifs.isEmpty)
                      ...controller.notifications.map((n) =>
                          _NotifTile(item: n, onTap: () => controller.markRead(n.id))),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Section Header ───────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final String label;
  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFEEF4F7),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// ─── Notification Tile ────────────────────────────────────────────
class _NotifTile extends StatelessWidget {
  final NotifItem item;
  final VoidCallback onTap;
  const _NotifTile({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        decoration: BoxDecoration(
          color: item.isRead ? Colors.white : Colors.white,
          border: const Border(
              bottom: BorderSide(color: AppColors.divider, width: 0.5)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Avatar / Icon ───────────────────────────────────
            _NotifAvatar(item: item),
            const SizedBox(width: 14),

            // ── Content ─────────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Message text
                  Text(
                    item.message,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textPrimary,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 5),

                  // Time
                  Text(item.time,
                      style: AppTextStyles.caption
                          .copyWith(color: AppColors.textTertiary)),

                  // Points badge
                  if (item.hasPoints) ...[
                    const SizedBox(height: 6),
                    _PointsBadge(points: item.points),
                  ],
                ],
              ),
            ),

            // ── Right image thumbnail ────────────────────────────
            if (item.hasImage) ...[
              const SizedBox(width: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 52,
                  height: 52,
                  color: const Color(0xFFB0A098),
                  child: const Center(
                    child: Icon(Icons.checkroom_outlined,
                        color: Colors.white54, size: 24),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─── Avatar ───────────────────────────────────────────────────────
class _NotifAvatar extends StatelessWidget {
  final NotifItem item;
  const _NotifAvatar({required this.item});

  @override
  Widget build(BuildContext context) {
    // Points notification → icon instead of avatar
    if (item.type == NotifType.points) {
      return Container(
        width: 48, height: 48,
        decoration: BoxDecoration(
          color: const Color(0xFFD4E8F4),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.workspace_premium_outlined,
            color: Color(0xFF4A90D9), size: 24),
      );
    }

    return Stack(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: item.avatarColor,
          child: Text(
            item.userName.isNotEmpty ? item.userName[0] : '?',
            style: AppTextStyles.headlineSmall.copyWith(color: Colors.white),
          ),
        ),
        // Small icon badge bottom-right
        Positioned(
          bottom: 0, right: 0,
          child: Container(
            width: 18, height: 18,
            decoration: BoxDecoration(
              color: _badgeColor(item.type),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1.5),
            ),
            child: Icon(_badgeIcon(item.type),
                color: Colors.white, size: 10),
          ),
        ),
      ],
    );
  }

  Color _badgeColor(NotifType t) {
    switch (t) {
      case NotifType.like:    return Colors.red;
      case NotifType.follow:  return const Color(0xFF4A90D9);
      case NotifType.comment: return AppColors.primary;
      case NotifType.repost:  return const Color(0xFF4CAF50);
      default:                return AppColors.accent;
    }
  }

  IconData _badgeIcon(NotifType t) {
    switch (t) {
      case NotifType.like:    return Icons.favorite;
      case NotifType.follow:  return Icons.person_add;
      case NotifType.comment: return Icons.chat_bubble;
      case NotifType.repost:  return Icons.repeat;
      default:                return Icons.star;
    }
  }
}

// ─── Points Badge ─────────────────────────────────────────────────
class _PointsBadge extends StatelessWidget {
  final int points;
  const _PointsBadge({required this.points});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFD4E8F4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.workspace_premium_outlined,
              size: 13, color: Color(0xFF4A90D9)),
          const SizedBox(width: 4),
          Text(
            '+$points pts',
            style: AppTextStyles.caption.copyWith(
              color: const Color(0xFF4A90D9),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}