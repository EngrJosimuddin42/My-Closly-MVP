import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../widgets/app_widgets.dart';
import '../onboarding_controller.dart';

class StepCategory extends GetView<OnboardingController> {
  const StepCategory({super.key});

  static const _catIcons = {
    'Tops': Icons.dry_cleaning_outlined,
    'Dresses': Icons.checkroom_outlined,
    'Jeans': Icons.straighten_outlined,
    'Pants': Icons.straighten_outlined,
    'Shoes': Icons.directions_walk_outlined,
    'Jackets': Icons.dry_outlined,
    'Bags': Icons.shopping_bag_outlined,
    'Accessories': Icons.watch_outlined,
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Category', style: AppTextStyles.overline),
          const SizedBox(height: 6),
          RichText(
            text: TextSpan(children: [
              TextSpan(text: 'What do you ', style: AppTextStyles.displaySmall),
              TextSpan(
                text: 'shop most?',
                style: AppTextStyles.displayItalicSmall.copyWith(fontSize: 26),
              ),
            ]),
          ),
          Text('Select your favorite categories.', style: AppTextStyles.bodyMedium),
          const SizedBox(height: 24),

          Obx(() => GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.4,
            ),
            itemCount: controller.categories.length,
            itemBuilder: (_, i) {
              final cat = controller.categories[i];
              final isSelected = controller.selectedCategories.contains(cat);
              return GestureDetector(
                onTap: () => controller.toggleCategory(cat),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.border,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _catIcons[cat] ?? Icons.category_outlined,
                        color: isSelected ? Colors.white : AppColors.textSecondary,
                        size: 28,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        cat,
                        style: AppTextStyles.labelMedium.copyWith(
                          color: isSelected ? Colors.white : AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
          const SizedBox(height: 32),
          AppPrimaryButton(label: 'Continue', onTap: controller.onNext),
        ],
      ),
    );
  }
}