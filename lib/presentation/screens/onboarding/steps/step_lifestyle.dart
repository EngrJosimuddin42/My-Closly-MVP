import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../widgets/app_widgets.dart';
import '../onboarding_controller.dart';

class StepLifestyle extends GetView<OnboardingController> {
  const StepLifestyle({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Lifestyle', style: AppTextStyles.overline),
          const SizedBox(height: 6),
          RichText(
            text: TextSpan(children: [
              TextSpan(text: 'How do you spend ', style: AppTextStyles.displaySmall),
              TextSpan(
                text: 'most\ndays?',
                style: AppTextStyles.displayItalicSmall.copyWith(fontSize: 26),
              ),
            ]),
          ),
          Text('This helps us recommend the right products.', style: AppTextStyles.bodyMedium),
          const SizedBox(height: 24),

          Obx(() => GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.5,
            ),
            itemCount: controller.lifestyles.length,
            itemBuilder: (_, i) {
              final lifestyle = controller.lifestyles[i];
              final isSelected = controller.selectedLifestyle.value == lifestyle;
              return GestureDetector(
                onTap: () => controller.selectLifestyle(lifestyle),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7A8A82),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? Colors.white : Colors.transparent,
                      width: 2.5,
                    ),
                    boxShadow: isSelected
                        ? [const BoxShadow(color: Color(0x30000000), blurRadius: 10)]
                        : null,
                  ),
                  child: Stack(
                    children: [
                      if (isSelected)
                        const Positioned(
                          top: 8, right: 8,
                          child: Icon(Icons.check_circle, color: Colors.white, size: 20),
                        ),
                      Positioned(
                        bottom: 12,
                        left: 12,
                        right: 12,
                        child: Text(
                          lifestyle,
                          style: AppTextStyles.labelMedium.copyWith(color: Colors.white),
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
          const SizedBox(height: 12),
          Center(
            child: GestureDetector(
              onTap: controller.onSkip,
              child: Text('Skip', style: AppTextStyles.bodyMedium.copyWith(
                  decoration: TextDecoration.underline)),
            ),
          ),
        ],
      ),
    );
  }
}