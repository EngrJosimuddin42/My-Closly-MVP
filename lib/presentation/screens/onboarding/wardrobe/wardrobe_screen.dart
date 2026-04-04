import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../widgets/app_widgets.dart';
import 'wardrobe_controller.dart';

class WardrobeScreen extends GetView<WardrobeController> {
  const WardrobeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back
              GestureDetector(
                onTap: Get.back,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new,
                      size: 16, color: AppColors.textPrimary),
                ),
              ),
              const SizedBox(height: 20),

              Text('Closet', style: AppTextStyles.overline),
              const SizedBox(height: 6),
              RichText(
                text: TextSpan(children: [
                  TextSpan(text: 'Import your ', style: AppTextStyles.displaySmall),
                  TextSpan(
                    text: 'wardrobe.',
                    style: AppTextStyles.displayItalicSmall,
                  ),
                ]),
              ),
              const SizedBox(height: 6),
              Text(
                'The more we know, the smarter your recommendations.',
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: 28),

              // Photo Scan option
              _ImportOption(
                icon: Icons.camera_alt_outlined,
                title: 'Photo Scan',
                subtitle: 'Take photos of your pieces. AI identifies each item automatically.',
                onTap: controller.onPhotoScan,
                isDark: true,
              ),
              const SizedBox(height: 14),

              // Add Manually option
              _ImportOption(
                icon: Icons.add,
                title: 'Add Manually',
                subtitle: 'Search and add pieces by brand, name or category.',
                onTap: controller.onAddManually,
                isDark: false,
              ),

              const SizedBox(height: 24),

              // Recently Added
              Obx(() {
                if (controller.recentlyAdded.isEmpty) return const SizedBox.shrink();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Recently Added', style: AppTextStyles.labelMedium),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 72,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.recentlyAdded.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemBuilder: (_, i) {
                          final item = controller.recentlyAdded[i];
                          return Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              color: AppColors.scannerBackground.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.directions_walk,
                                color: AppColors.textTertiary, size: 30),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                );
              }),

              const Spacer(),
              // Continue to scan
              // Continue to scan
              Obx(() {
                return Column(
                  children: [
                    if (controller.hasItems)
                      AppPrimaryButton(
                        label: 'Finish',
                        onTap: controller.onFinish,
                      )
                    else
                      Center(
                        child: GestureDetector(
                          onTap: controller.onSkip,
                          child: Text(
                            'Skip',
                            style: AppTextStyles.bodyMedium.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              }),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImportOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isDark;

  const _ImportOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isDark ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: isDark ? null : Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withOpacity(0.12)
                    : AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isDark ? Colors.white : AppColors.textSecondary,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.labelMedium.copyWith(
                      color: isDark ? Colors.white : AppColors.textPrimary,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: isDark ? Colors.white60 : AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}