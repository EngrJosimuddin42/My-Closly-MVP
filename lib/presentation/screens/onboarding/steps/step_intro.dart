import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../widgets/app_widgets.dart';
import '../onboarding_controller.dart';

class StepIntro extends GetView<OnboardingController> {
  const StepIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          color: const Color(0xFF5A4A42),
          child: Opacity(
            opacity: 0.4,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage('https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=600'),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 2),
              Text(AppStrings.aiPoweredFashion,
                  style: AppTextStyles.overline.copyWith(color: AppColors.accent.withOpacity(0.8))),
              const SizedBox(height: 12),
              Text(AppStrings.letAiCreate, style: AppTextStyles.displayMediumWhite),
              Text(
                AppStrings.yourStyle,
                style: AppTextStyles.displayItalicWhite.copyWith(color: const Color(0xFFCFAB7A)),
              ),
              const SizedBox(height: 14),
              Text(AppStrings.onboardingSubtitle,
                  style: AppTextStyles.bodyMediumWhite.copyWith(height: 1.6)),
              const Spacer(flex: 3),
              AppPrimaryButton(
                label: AppStrings.continueBtn,
                onTap: controller.onNext,
                backgroundColor: AppColors.primary,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }
}