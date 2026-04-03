import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../closet/closet_screen.dart';
import '../home/home_screen.dart';
import '../message/message_screen.dart';
import '../profile/profile_screen.dart';
import 'main_controller.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
        index: controller.currentIndex.value,
        children: const [
          HomeBody(),       // 0 - Home
          MessageScreen(),  // 1 - Message
          ClosetScreen(),   //2- Closet
          ProfileScreen(),  // 3 - Profile
        ],
      )),
      bottomNavigationBar: const _MainBottomNav(),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder();
  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

// ─── Bottom Nav ───────────────────────────────────────────────────
class _MainBottomNav extends GetView<MainController> {
  const _MainBottomNav({super.key});

  static const _items = [
    _NavItem(icon: Icons.home_outlined,      label: 'Home'),
    _NavItem(icon: Icons.send_outlined,      label: 'Message'),
    _NavItem(icon: Icons.checkroom_outlined, label: 'Closet'),
    _NavItem(icon: Icons.person_outline,     label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.divider, width: 0.5)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (i) {
              final isSelected = controller.currentIndex.value == i;
              final item = _items[i];
              return InkWell(
                onTap: () => controller.onNavTap(i),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(item.icon, size: 24,
                          color: isSelected ? AppColors.primary : AppColors.textTertiary),
                      const SizedBox(height: 4),
                      Text(item.label,
                          style: AppTextStyles.caption.copyWith(
                            color: isSelected ? AppColors.primary : AppColors.textTertiary,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          )),
                    ],
                  ),
                ),
              );
            }),
          )),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}