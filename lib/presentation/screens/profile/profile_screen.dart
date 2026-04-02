import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(() => Stack(
        children: [
          // ── Main scrollable content ─────────────────────────────
          Column(
            children: [
              // Profile header (non-scrolling appbar area)
              _ProfileHeader(),

              // Tab bar
              _ProfileTabBar(),

              // Tab content — fills remaining space
              Expanded(
                child: Obx(() {
                  switch (controller.selectedTab.value) {
                    case 1: return _SavedTab();
                    case 2: return _LikesTab();
                    default: return _PostsTab();
                  }
                }),
              ),
            ],
          ),

          // ── Dropdown menu overlay ───────────────────────────────
          if (controller.showMenu.value) ...[
            GestureDetector(
              onTap: controller.closeMenu,
              child: Container(color: Colors.transparent),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 48,
              right: 16,
              child: _DropdownMenu(),
            ),
          ],
        ],
      )),
    );
  }
}

// ─── Profile Header ───────────────────────────────────────────────
class _ProfileHeader extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AppBar row
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 4, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Profile', style: AppTextStyles.headlineSmall),
                  IconButton(
                    icon: const Icon(Icons.more_vert,
                        color: AppColors.textPrimary),
                    onPressed: controller.toggleMenu,
                  ),
                ],
              ),
            ),

            // Avatar + body icons row
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 34,
                        backgroundColor:
                        AppColors.accent.withOpacity(0.2),
                        child: const Icon(Icons.person,
                            size: 34, color: AppColors.accent),
                      ),
                      Positioned(
                        bottom: 2, right: 2,
                        child: Container(
                          width: 11, height: 11,
                          decoration: BoxDecoration(
                            color: AppColors.success,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 14),
                  Row(
                    children: const [
                      Icon(Icons.accessibility_new,
                          size: 26, color: AppColors.textTertiary),
                      Icon(Icons.accessibility_new,
                          size: 20, color: AppColors.textTertiary),
                      Icon(Icons.accessible,
                          size: 20, color: AppColors.textTertiary),
                    ],
                  ),
                ],
              ),
            ),

            // Name, handle, bio
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text(controller.userName.value,
                      style: AppTextStyles.headlineMedium)),
                  const SizedBox(height: 2),
                  Obx(() => Text(controller.userHandle.value,
                      style: AppTextStyles.bodySmall
                          .copyWith(color: AppColors.textTertiary))),
                  const SizedBox(height: 3),
                  Obx(() => Text(controller.userBio.value,
                      style: AppTextStyles.bodySmall)),
                ],
              ),
            ),

            // Stats row
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
              child: Row(
                children: [
                  _StatItem(label: 'POSTS', value: '284'),
                  const SizedBox(width: 24),
                  GestureDetector(
                    onTap: controller.onFollowersTap,
                    child: _StatItem(label: 'FOLLOWERS', value: '1.2k'),
                  ),
                  const SizedBox(width: 24),
                  _StatItem(label: 'FOLLOWING', value: '63'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: AppTextStyles.headlineMedium),
        Text(label,
            style: AppTextStyles.caption
                .copyWith(color: AppColors.textTertiary)),
      ],
    );
  }
}

// ─── Tab Bar ──────────────────────────────────────────────────────
class _ProfileTabBar extends GetView<ProfileController> {
  static const _tabs = ['POSTS', 'SAVED', 'LIKES'];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Obx(() => Row(
        children: List.generate(_tabs.length, (i) {
          final isSelected = controller.selectedTab.value == i;
          return Expanded(
            child: GestureDetector(
              onTap: () => controller.setTab(i),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.divider,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  _tabs[i],
                  textAlign: TextAlign.center,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textTertiary,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ),
          );
        }),
      )),
    );
  }
}

// ─── Posts Tab ────────────────────────────────────────────────────
class _PostsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = [
      const Color(0xFF8A7B6F), const Color(0xFFB0A098),
      const Color(0xFF6B5B52), const Color(0xFF9A8878),
      const Color(0xFF7A6A60), const Color(0xFFD4B096),
      const Color(0xFFA09088), const Color(0xFF5A4A42),
      const Color(0xFFC4B4A8),
    ];
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 1.5,
        mainAxisSpacing: 1.5,
      ),
      itemCount: 9,
      itemBuilder: (_, i) => Container(
        color: colors[i % colors.length],
        child: const Center(
          child: Icon(Icons.checkroom_outlined,
              color: Colors.white30, size: 28),
        ),
      ),
    );
  }
}

// ─── Saved Tab ────────────────────────────────────────────────────
class _SavedTab extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    final colors = [
      const Color(0xFF8A9BAA), const Color(0xFFD4D4D4),
      const Color(0xFFD4A870), const Color(0xFF8A7060),
      const Color(0xFF2A2A2A), const Color(0xFFD4C8B8),
    ];
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.68,
      ),
      itemCount: controller.savedItems.length,
      itemBuilder: (_, i) {
        final item = controller.savedItems[i];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: colors[i % colors.length],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(Icons.checkroom_outlined,
                      color: Colors.white30, size: 22),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(item['brand']!,
                style: AppTextStyles.caption
                    .copyWith(color: AppColors.textTertiary)),
            Text(item['name']!,
                style: AppTextStyles.labelSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
            Text(item['price']!,
                style: AppTextStyles.caption
                    .copyWith(color: AppColors.accent)),
          ],
        );
      },
    );
  }
}

// ─── Likes Tab ────────────────────────────────────────────────────
class _LikesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = [
      const Color(0xFF9A8878), const Color(0xFF7A6A60),
      const Color(0xFFD4B096), const Color(0xFFA09088),
      const Color(0xFF5A4A42), const Color(0xFFC4B4A8),
    ];
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 1.5,
        mainAxisSpacing: 1.5,
      ),
      itemCount: 6,
      itemBuilder: (_, i) => Container(
        color: colors[i % colors.length],
        child: const Center(
          child: Icon(Icons.favorite_border,
              color: Colors.white30, size: 24),
        ),
      ),
    );
  }
}

// ─── Dropdown Menu ────────────────────────────────────────────────
class _DropdownMenu extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.share_outlined,     'label': 'Share Profile',     'action': controller.onShareProfile},
      {'icon': Icons.link_outlined,      'label': 'Copy Profile Link', 'action': controller.onCopyProfileLink},
      {'icon': Icons.star_outline,       'label': 'Closet Points',     'action': controller.onClosetPoints},
      {'icon': Icons.person_add_outlined,'label': 'Invite Friends',    'action': controller.onInviteFriends},
      {'icon': Icons.edit_outlined,      'label': 'Edit Profile',      'action': controller.onEditProfile},
      {'icon': Icons.settings_outlined,  'label': 'Settings',          'action': controller.onSettings},
    ];

    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(14),
      shadowColor: Colors.black26,
      child: Container(
        width: 220,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: items.asMap().entries.map((e) {
            final item = e.value;
            final isLast = e.key == items.length - 1;
            return GestureDetector(
              onTap: item['action'] as VoidCallback,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 13),
                decoration: BoxDecoration(
                  border: isLast
                      ? null
                      : const Border(
                      bottom: BorderSide(
                          color: AppColors.divider, width: 0.5)),
                ),
                child: Row(
                  children: [
                    Icon(item['icon'] as IconData,
                        size: 18, color: AppColors.textSecondary),
                    const SizedBox(width: 12),
                    Text(item['label'] as String,
                        style: AppTextStyles.bodyMedium
                            .copyWith(color: AppColors.textPrimary)),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}