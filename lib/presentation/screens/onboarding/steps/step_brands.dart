import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../widgets/app_widgets.dart';
import '../onboarding_controller.dart';

class StepBrands extends GetView<OnboardingController> {
  const StepBrands({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Brand', style: AppTextStyles.overline),
          const SizedBox(height: 6),
          RichText(
            text: TextSpan(children: [
              TextSpan(text: 'Your favorite ', style: AppTextStyles.displaySmall),
              TextSpan(
                text: 'brands?',
                style: AppTextStyles.displayItalicSmall.copyWith(fontSize: 26),
              ),
            ]),
          ),
          Text('Choose brands you love.', style: AppTextStyles.bodyMedium),
          const SizedBox(height: 20),

          // Search field
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: TextField(
              controller: controller.brandSearchController,
              style: AppTextStyles.bodyMedium,
              decoration: InputDecoration(
                hintText: 'Search brands...',
                hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textTertiary),
                prefixIcon: const Icon(Icons.search, color: AppColors.textTertiary, size: 20),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Brand chips
          Obx(() => Wrap(
            spacing: 10,
            runSpacing: 10,
            children: controller.brandOptions.map((brand) {
              final isSelected = controller.selectedBrands.contains(brand);
              return GestureDetector(
                onTap: () => controller.toggleBrand(brand),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.border,
                    ),
                  ),
                  child: Text(
                    brand,
                    style: AppTextStyles.labelMedium.copyWith(
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                ),
              );
            }).toList(),
          )),
          const SizedBox(height: 32),

          AppPrimaryButton(label: 'Continue', onTap: controller.onNext),
          const SizedBox(height: 12),
          Center(
            child: GestureDetector(
              onTap: controller.onSkip,
              child: Text('Skip', style: AppTextStyles.bodyMedium.copyWith(
                decoration: TextDecoration.underline,
              )),
            ),
          ),
        ],
      ),
    );
  }
}