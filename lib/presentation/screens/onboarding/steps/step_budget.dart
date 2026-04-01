import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../widgets/app_widgets.dart';
import '../onboarding_controller.dart';

class StepBudget extends GetView<OnboardingController> {
  const StepBudget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Budget', style: AppTextStyles.overline),
          const SizedBox(height: 6),
          RichText(
            text: TextSpan(children: [
              TextSpan(text: "What's your usual\n", style: AppTextStyles.displaySmall),
              TextSpan(
                text: 'shopping level?',
                style: AppTextStyles.displayItalicSmall.copyWith(fontSize: 26),
              ),
            ]),
          ),
          Text('This helps us recommend the right products.', style: AppTextStyles.bodyMedium),
          const SizedBox(height: 28),

          Obx(() => Column(
            children: [
              _BudgetSlider(
                icon: Icons.dry_cleaning_outlined,
                label: 'T-Shirts',
                levelLabel: 'High Street',
                value: controller.tShirtBudget.value,
                max: 120,
                prefix: 'up to €',
                onChanged: (v) => controller.tShirtBudget.value = v,
              ),
              _BudgetSlider(
                icon: Icons.straighten_outlined,
                label: 'Trousers',
                levelLabel: 'Contemporary',
                value: controller.trouserBudget.value,
                max: 240,
                prefix: 'up to €',
                onChanged: (v) => controller.trouserBudget.value = v,
              ),
              _BudgetSlider(
                icon: Icons.directions_walk_outlined,
                label: 'Shoes',
                levelLabel: 'Contemporary',
                value: controller.shoesBudget.value,
                max: 360,
                prefix: 'up to €',
                onChanged: (v) => controller.shoesBudget.value = v,
              ),
              _BudgetSlider(
                icon: Icons.shopping_bag_outlined,
                label: 'Bags',
                levelLabel: 'Contemporary',
                value: controller.bagsBudget.value,
                max: 500,
                prefix: 'up to €',
                onChanged: (v) => controller.bagsBudget.value = v,
              ),
              _BudgetSlider(
                icon: Icons.dry_outlined,
                label: 'Knitwear',
                levelLabel: 'Contemporary',
                value: controller.knitwearBudget.value,
                max: 200,
                prefix: 'up to €',
                onChanged: (v) => controller.knitwearBudget.value = v,
              ),
            ],
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

class _BudgetSlider extends StatelessWidget {
  final IconData icon;
  final String label;
  final String levelLabel;
  final double value;
  final double max;
  final String prefix;
  final void Function(double) onChanged;

  const _BudgetSlider({
    required this.icon,
    required this.label,
    required this.levelLabel,
    required this.value,
    required this.max,
    required this.prefix,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, size: 18, color: AppColors.textSecondary),
                  const SizedBox(width: 8),
                  Text(label, style: AppTextStyles.labelMedium),
                ],
              ),
              Text(
                '$prefix${value.toInt()}',
                style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary),
              ),
            ],
          ),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: AppColors.primary,
              inactiveTrackColor: AppColors.divider,
              thumbColor: AppColors.primary,
              overlayColor: AppColors.primary.withOpacity(0.1),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
              trackHeight: 3,
            ),
            child: Slider(
              value: value,
              min: 0,
              max: max,
              onChanged: onChanged,
            ),
          ),
          Text(levelLabel,
              style: AppTextStyles.caption.copyWith(color: AppColors.textTertiary)),
        ],
      ),
    );
  }
}