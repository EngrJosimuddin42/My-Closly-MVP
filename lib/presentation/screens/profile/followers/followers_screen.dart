import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'followers_controller.dart';

class FollowersScreen extends GetView<FollowersController> {
  const FollowersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => Text(
                    '${_formatNumber(controller.totalFollowers.value)} Followers',
                    style: AppTextStyles.headlineLarge,
                  )),
                  GestureDetector(
                    onTap: Get.back,
                    child: Container(
                      width: 32, height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.border),
                      ),
                      child: const Icon(Icons.close, size: 16, color: AppColors.textPrimary),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Search
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: TextField(
                  controller: controller.searchController,
                  style: AppTextStyles.bodyMedium,
                  decoration: InputDecoration(
                    hintText: 'Search followers',
                    hintStyle: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textTertiary),
                    prefixIcon: const Icon(Icons.search,
                        color: AppColors.textTertiary, size: 20),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 13),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Filter chips
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Obx(() => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _FilterChip(label: 'All', filter: FollowerFilter.all,
                        selected: controller.selectedFilter.value == FollowerFilter.all,
                        onTap: () => controller.setFilter(FollowerFilter.all)),
                    const SizedBox(width: 8),
                    _FilterChip(label: 'DNA Match', filter: FollowerFilter.dnaMatch,
                        selected: controller.selectedFilter.value == FollowerFilter.dnaMatch,
                        onTap: () => controller.setFilter(FollowerFilter.dnaMatch)),
                    const SizedBox(width: 8),
                    _FilterChip(label: 'New', filter: FollowerFilter.newFollowers,
                        selected: controller.selectedFilter.value == FollowerFilter.newFollowers,
                        onTap: () => controller.setFilter(FollowerFilter.newFollowers)),
                    const SizedBox(width: 8),
                    _FilterChip(label: 'München', filter: FollowerFilter.location,
                        selected: controller.selectedFilter.value == FollowerFilter.location,
                        onTap: () => controller.setFilter(FollowerFilter.location)),
                  ],
                ),
              )),
            ),
            const SizedBox(height: 18),

            // List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  // Suggested — High DNA Match
                  Text('SUGGESTED — HIGH DNA MATCH',
                      style: AppTextStyles.caption.copyWith(
                          color: AppColors.textTertiary, letterSpacing: 0.8)),
                  const SizedBox(height: 10),
                  ...controller.suggested.map((u) => _FollowerTile(user: u)),
                  const SizedBox(height: 20),

                  // New Followers
                  Text('NEW FOLLOWERS',
                      style: AppTextStyles.caption.copyWith(
                          color: AppColors.textTertiary, letterSpacing: 0.8)),
                  const SizedBox(height: 10),
                  ...controller.newFollowers.map((u) => _FollowerTile(user: u)),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatNumber(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}k'.replaceAll('.0k', 'k');
    return '$n';
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final FollowerFilter filter;
  final bool selected;
  final VoidCallback onTap;
  const _FilterChip({required this.label, required this.filter,
    required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: selected ? AppColors.primary : AppColors.border),
        ),
        child: Text(label,
            style: AppTextStyles.labelSmall.copyWith(
                color: selected ? Colors.white : AppColors.textPrimary)),
      ),
    );
  }
}

class _FollowerTile extends GetView<FollowersController> {
  final FollowerUser user;
  const _FollowerTile({required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.accent.withOpacity(0.2),
            child: Text(user.name[0],
                style: AppTextStyles.headlineSmall.copyWith(color: AppColors.accent)),
          ),
          const SizedBox(width: 12),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name, style: AppTextStyles.labelLarge),
                Text(user.location, style: AppTextStyles.bodySmall),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4A90D9).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text('DNA ${user.dnaMatch}%',
                          style: AppTextStyles.caption.copyWith(
                              color: const Color(0xFF4A90D9),
                              fontWeight: FontWeight.w700)),
                    ),
                    if (user.styleTag.isNotEmpty) ...[
                      const SizedBox(width: 6),
                      Text(user.styleTag,
                          style: AppTextStyles.caption.copyWith(
                              color: AppColors.textTertiary)),
                    ],
                  ],
                ),
              ],
            ),
          ),

          // Follow button
          Obx(() {
            final isFollowing = controller.followingStates[user.name] ?? false;
            return GestureDetector(
              onTap: () => controller.toggleFollow(user.name),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isFollowing ? Colors.white : AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: isFollowing ? AppColors.border : AppColors.primary),
                ),
                child: Text(
                  isFollowing ? 'Following' : 'Follow',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: isFollowing ? AppColors.textPrimary : Colors.white,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}