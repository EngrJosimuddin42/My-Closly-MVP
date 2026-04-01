import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../widgets/app_widgets.dart';
import '../onboarding_controller.dart';

class StyleSelectionStep extends GetView<OnboardingController> {
  const StyleSelectionStep({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Style', style: AppTextStyles.overline),
          const SizedBox(height: 6),
          RichText(
            text: TextSpan(children: [
              TextSpan(text: 'What styles ', style: AppTextStyles.displaySmall),
              TextSpan(
                text: 'match you?',
                style: AppTextStyles.displayItalicSmall.copyWith(fontSize: 26),
              ),
            ]),
          ),
          Text('Pick 3–5 styles. (4 selected)', style: AppTextStyles.bodyMedium),
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
            itemCount: controller.styleOptions.length,
            itemBuilder: (_, i) {
              final style = controller.styleOptions[i];
              final isSelected = controller.selectedStyles.contains(style);
              return GestureDetector(
                onTap: () => controller.toggleStyle(style),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  decoration: BoxDecoration(
                    color: const Color(0xFF8A7A70),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? Colors.white : Colors.transparent,
                      width: 2.5,
                    ),
                    boxShadow: isSelected
                        ? [const BoxShadow(color: Color(0x40000000), blurRadius: 8)]
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
                        bottom: 10,
                        left: 12,
                        child: Text(style,
                            style: AppTextStyles.labelMedium.copyWith(color: Colors.white)),
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