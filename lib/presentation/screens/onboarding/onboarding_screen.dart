import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myclosly/presentation/screens/onboarding/steps/step_style.dart';
import '../../../core/theme/app_colors.dart';
import 'onboarding_controller.dart';
import 'steps/step_intro.dart';
import 'steps/step_body_profile.dart';
import 'steps/step_fit_measurements.dart';
import 'steps/step_appearance.dart';
import 'steps/step_color_preferences.dart';
import 'steps/step_category.dart';
import 'steps/step_brands.dart';
import 'steps/step_budget.dart';
import 'steps/step_lifestyle.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _OnboardingHeader(),
            Expanded(
              child: PageView(
                controller: controller.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  StepIntro(),
                  StepBodyProfile(),
                  StepFitMeasurements(),
                  StepAppearance(),
                  StepColorPreferences(),
                  StyleSelectionStep(),
                  StepCategory(),
                  StepBrands(),
                  StepBudget(),
                  StepLifestyle(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingHeader extends GetView<OnboardingController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final step = controller.currentStep.value;
      final isIntro = step == 0;

      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
        child: Row(
          children: [
            GestureDetector(
              onTap: controller.onBack,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Icon(Icons.arrow_back_ios_new, size: 16, color: AppColors.textPrimary),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: isIntro
                  ? const SizedBox()
                  : ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: controller.progress,
                  backgroundColor: AppColors.divider,
                  valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                  minHeight: 4,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}