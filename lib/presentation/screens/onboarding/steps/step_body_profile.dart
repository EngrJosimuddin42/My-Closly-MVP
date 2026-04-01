import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../widgets/app_widgets.dart';
import '../onboarding_controller.dart';

class StepBodyProfile extends GetView<OnboardingController> {
  const StepBodyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Fitness', style: AppTextStyles.overline),
          const SizedBox(height: 6),
          RichText(
            text: TextSpan(children: [
              TextSpan(text: 'Your body ', style: AppTextStyles.displaySmall),
              TextSpan(
                text: 'profile',
                style: AppTextStyles.displayItalicSmall.copyWith(fontSize: 28),
              ),
            ]),
          ),
          const SizedBox(height: 6),
          Text(
            'These details help us recommend clothes that fit better.',
            style: AppTextStyles.bodyMedium,
          ),
          const SizedBox(height: 24),

          // Weight
          _BodyInput(
            label: 'Weight',
            controller: controller.weightController,
            suffix: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _UnitToggle(label: 'kg', isSelected: true, onTap: () {}),
                const SizedBox(width: 4),
                _UnitToggle(label: 'lbs', isSelected: false, onTap: () {}),
              ],
            ),
          ),
          const SizedBox(height: 14),

          _BodyInput(label: 'Height', controller: controller.heightController, unit: 'cm'),
          const SizedBox(height: 14),
          _BodyInput(label: 'Chest', controller: controller.chestController, unit: 'cm'),
          const SizedBox(height: 14),
          _BodyInput(label: 'Waist', controller: controller.waistController, unit: 'cm'),
          const SizedBox(height: 14),
          _BodyInput(label: 'Hip', controller: controller.hipController, unit: 'cm'),
          const SizedBox(height: 22),

          // Body Size
          Text('Body Size', style: AppTextStyles.labelMedium),
          const SizedBox(height: 10),
          Obx(() => Wrap(
            spacing: 10,
            children: controller.bodySizes.map((s) {
              final isSelected = controller.selectedBodySize.value == s;
              return GestureDetector(
                onTap: () => controller.selectBodySize(s),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.border,
                    ),
                  ),
                  child: Text(
                    s,
                    style: AppTextStyles.labelMedium.copyWith(
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                ),
              );
            }).toList(),
          )),
          const SizedBox(height: 22),

          // Shoe Size
          Text('Shoe Size', style: AppTextStyles.labelMedium),
          const SizedBox(height: 10),
          Obx(() => Wrap(
            spacing: 10,
            children: controller.shoeSizes.map((s) {
              final isSelected = controller.selectedShoeSize.value == s;
              return GestureDetector(
                onTap: () => controller.selectShoeSize(s),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.border,
                    ),
                  ),
                  child: Text(
                    '$s',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                ),
              );
            }).toList(),
          )),
          const SizedBox(height: 8),
          Text(
            'This helps our AI recommend better sizes and fits for you.',
            style: AppTextStyles.bodySmall,
          ),
          const SizedBox(height: 32),

          AppPrimaryButton(label: 'Continue', onTap: controller.onNext),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _BodyInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? unit;
  final Widget? suffix;

  const _BodyInput({
    required this.label,
    required this.controller,
    this.unit,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.labelMedium),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                keyboardType: TextInputType.number,
                style: AppTextStyles.bodyLarge,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            if (unit != null) ...[
              const SizedBox(width: 10),
              Text(unit!, style: AppTextStyles.labelMedium),
            ],
            if (suffix != null) ...[
              const SizedBox(width: 10),
              suffix!,
            ],
          ],
        ),
      ],
    );
  }
}

class _UnitToggle extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _UnitToggle({required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: isSelected ? AppColors.primary : AppColors.border),
        ),
        child: Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: isSelected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}