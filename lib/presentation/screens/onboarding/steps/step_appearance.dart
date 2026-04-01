import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../widgets/app_widgets.dart';
import '../onboarding_controller.dart';

class StepAppearance extends GetView<OnboardingController> {
  const StepAppearance({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Appearance Preferences', style: AppTextStyles.overline),
          const SizedBox(height: 6),
          RichText(
            text: TextSpan(children: [
              TextSpan(text: 'Your natural look ', style: AppTextStyles.displaySmall),
              TextSpan(text: '&\nfeatures',
                  style: AppTextStyles.displayItalicSmall.copyWith(fontSize: 26)),
            ]),
          ),
          const SizedBox(height: 4),
          Text('Helps us suggest colours that complement you',
              style: AppTextStyles.bodyMedium),
          const SizedBox(height: 24),

          // Hair Colour
          Text('HAIR COLOUR', style: AppTextStyles.overline),
          const SizedBox(height: 12),
          Obx(() => SizedBox(
            height: 52,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: controller.hairColors.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (_, i) {
                final isSelected = controller.selectedHairColor.value == i;
                return GestureDetector(
                  onTap: () => controller.selectHairColor(i),
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _hairColorMap[controller.hairColors[i]],
                      border: Border.all(
                        color: isSelected ? AppColors.primary : AppColors.border,
                        width: isSelected ? 2.5 : 1,
                      ),
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, color: Colors.white, size: 18)
                        : null,
                  ),
                );
              },
            ),
          )),
          const SizedBox(height: 22),

          // Eye Colour
          Text('EYE COLOUR', style: AppTextStyles.overline),
          const SizedBox(height: 12),
          Obx(() => Wrap(
            spacing: 10,
            runSpacing: 10,
            children: controller.eyeColors.map((c) {
              final isSelected = controller.selectedEyeColor.value == c;
              return GestureDetector(
                onTap: () => controller.selectEyeColor(c),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary.withOpacity(0.08) : Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.border,
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _eyeColorMap[c] ?? AppColors.textTertiary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(c, style: AppTextStyles.labelMedium),
                    ],
                  ),
                ),
              );
            }).toList(),
          )),
          const SizedBox(height: 22),

          // Skin Tone
          Text('SKIN TONE', style: AppTextStyles.overline),
          const SizedBox(height: 6),
          Text("Helps suggest colours that complement your natural look.",
              style: AppTextStyles.bodySmall),
          const SizedBox(height: 12),
          Obx(() => Row(
            children: List.generate(controller.skinTones.length, (i) {
              final isSelected = controller.selectedSkinTone.value == i;
              return Expanded(
                child: GestureDetector(
                  onTap: () => controller.selectSkinTone(i),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    height: 36,
                    decoration: BoxDecoration(
                      color: controller.skinTones[i],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected ? AppColors.primary : Colors.transparent,
                        width: 2.5,
                      ),
                    ),
                  ),
                ),
              );
            }),
          )),
          const SizedBox(height: 32),
          AppPrimaryButton(label: 'Continue', onTap: controller.onNext),
        ],
      ),
    );
  }

  static const _hairColorMap = {
    'Black': Color(0xFF1A1A1A),
    'Brown': Color(0xFF6B3A2A),
    'Blonde': Color(0xFFD4A84B),
    'Red': Color(0xFFB84020),
    'Grey': Color(0xFF9A9A9A),
  };

  static const _eyeColorMap = {
    'Brown': Color(0xFF6B3A2A),
    'Blue': Color(0xFF4A7CB5),
    'Green': Color(0xFF4A7A4A),
    'Grey': Color(0xFF8A8A9A),
  };
}