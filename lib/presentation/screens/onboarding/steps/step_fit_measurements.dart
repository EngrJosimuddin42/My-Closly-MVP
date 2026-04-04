import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../widgets/app_widgets.dart';
import '../onboarding_controller.dart';

class StepFitMeasurements extends GetView<OnboardingController> {
  const StepFitMeasurements({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(' Body FIt', style: AppTextStyles.overline),
          const SizedBox(height: 6),
          RichText(
            text: TextSpan(children: [
              TextSpan(text: 'Fit & ', style: AppTextStyles.displaySmall),
              TextSpan(
                text: 'Measurements',
                style: AppTextStyles.displayItalicSmall.copyWith(fontSize: 26),
              ),
            ]),
          ),
          Text('For precise size recommendations optional editable anytime.',
              style: AppTextStyles.bodyMedium),
          const SizedBox(height: 28),

          // Body diagram with sliders
          _BodyDiagram(),

          const SizedBox(height: 28),

          // Body type selector
          Text('Body Type', style: AppTextStyles.labelMedium),
          const SizedBox(height: 12),
          Obx(() => Row(
            children: controller.bodyTypes.map((t) {
              final isSelected = controller.selectedBodyType.value == t;
              return Expanded(
                child: GestureDetector(
                  onTap: () => controller.selectBodyType(t),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.border),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.person_outline,
                            color: isSelected ? Colors.white : AppColors.textTertiary,
                            size: 22),
                        const SizedBox(height: 4),
                        Text(t,
                            style: AppTextStyles.labelSmall.copyWith(
                              color: isSelected ? Colors.white : AppColors.textSecondary,
                            )),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          )),
          const SizedBox(height: 32),
          AppPrimaryButton(label: 'Continue', onTap: controller.onNext),
        ],
      ),
    );
  }
}

class _BodyDiagram extends GetView<OnboardingController> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Body figure
        Expanded(
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Icon(Icons.accessibility_new, size: 80, color: AppColors.textTertiary),
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Measurement chips
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => _MeasurementChip(label: 'Chest size', value: controller.chestSize.value)),
            const SizedBox(height: 12),
            Obx(() => _MeasurementChip(label: 'Waist size', value: controller.waistSize.value)),
            const SizedBox(height: 12),
            Obx(() => _MeasurementChip(label: 'Hip size', value: controller.hipSize.value)),
            const SizedBox(height: 12),
            Obx(() => _MeasurementChip(label: 'Shoe size', value: controller.tipSize.value,
                isHighlighted: true)),
          ],
        ),
      ],
    );
  }
}

class _MeasurementChip extends StatelessWidget {
  final String label;
  final int value;
  final bool isHighlighted;

  const _MeasurementChip({
    required this.label,
    required this.value,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isHighlighted ? AppColors.primary.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isHighlighted ? AppColors.primary : AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$value', style: AppTextStyles.headlineSmall),
          Text(label, style: AppTextStyles.caption),
        ],
      ),
    );
  }
}