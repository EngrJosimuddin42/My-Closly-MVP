import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'edit_profile_controller.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: Get.back,
        ),
        title: Text('Edit Profile', style: AppTextStyles.headlineSmall),
        actions: [
          Obx(() => TextButton(
            onPressed: controller.onSave,
            child: controller.isLoading.value
                ? const SizedBox(
                width: 18, height: 18,
                child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary))
                : Text('Save',
                style: AppTextStyles.labelLarge.copyWith(color: AppColors.primary)),
          )),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // ── Avatar ───────────────────────────────────────────────
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 44,
                  backgroundColor: AppColors.accent.withOpacity(0.2),
                  child: const Icon(Icons.person, size: 44, color: AppColors.accent),
                ),
                Positioned(
                  bottom: 0, right: 0,
                  child: Container(
                    width: 28, height: 28,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(Icons.camera_alt, color: Colors.white, size: 14),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () {},
              child: Text('Change Profile Photo',
                  style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary)),
            ),
          ),
          const SizedBox(height: 8),

          // ── Basic Info ───────────────────────────────────────────
          _EditField(label: 'NAME', controller: controller.nameController),
          _EditField(label: 'USERNAME', controller: controller.usernameController),
          _EditField(label: 'BIO', controller: controller.bioController, maxLines: 3),
          _EditField(label: 'LOCATION', controller: controller.locationController),

          const SizedBox(height: 20),
          _SectionDivider(label: 'Private Information'),
          const SizedBox(height: 4),
          Text('Only you can see what you put on your profile.',
              style: AppTextStyles.bodySmall),
          const SizedBox(height: 12),

          _EditField(label: 'EMAIL', controller: controller.emailController,
              keyboardType: TextInputType.emailAddress),
          _EditField(label: 'PHONE', controller: controller.phoneController,
              keyboardType: TextInputType.phone),

          const SizedBox(height: 20),
          _SectionDivider(label: 'Style Preferences'),
          const SizedBox(height: 12),

          // Fashion styles
          Text('FASHION STYLES', style: AppTextStyles.caption),
          const SizedBox(height: 8),
          Obx(() => Wrap(
            spacing: 8, runSpacing: 8,
            children: controller.styleOptions.map((s) {
              final sel = controller.selectedStyles.contains(s);
              return _ToggleChip(label: s, selected: sel,
                  onTap: () => controller.toggleStyle(s));
            }).toList(),
          )),
          const SizedBox(height: 16),

          // Favourite brands
          Text('FAVOURITE BRANDS', style: AppTextStyles.caption),
          const SizedBox(height: 8),
          Obx(() => Wrap(
            spacing: 8, runSpacing: 8,
            children: controller.brandOptions.map((b) {
              final sel = controller.selectedBrands.contains(b);
              return _ToggleChip(label: b, selected: sel,
                  onTap: () => controller.toggleBrand(b));
            }).toList(),
          )),
          const SizedBox(height: 16),

          // Clothing budget
          Text('CLOTHING BUDGET', style: AppTextStyles.caption),
          const SizedBox(height: 8),
          Obx(() => Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: controller.clothingBudget.value,
                isExpanded: true,
                items: controller.budgetOptions.map((b) =>
                    DropdownMenuItem(value: b, child: Text(b, style: AppTextStyles.bodyMedium))
                ).toList()
                  ..insert(0, const DropdownMenuItem(value: 'Select', child: Text('Select'))),
                onChanged: (v) => controller.clothingBudget.value = v!,
                icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textTertiary),
              ),
            ),
          )),
          const SizedBox(height: 16),

          // Shopping interests
          Text('SHOPPING INTERESTS', style: AppTextStyles.caption),
          const SizedBox(height: 8),
          Obx(() => Wrap(
            spacing: 8, runSpacing: 8,
            children: controller.interestOptions.map((i) {
              final sel = controller.selectedInterests.contains(i);
              return _ToggleChip(label: i, selected: sel,
                  onTap: () => controller.toggleInterest(i));
            }).toList(),
          )),
          const SizedBox(height: 16),

          // Color palette
          Text('COLOR PALETTE', style: AppTextStyles.caption),
          const SizedBox(height: 8),
          Obx(() => Wrap(
            spacing: 8, runSpacing: 8,
            children: controller.colorOptions.map((c) {
              final sel = controller.selectedColors.contains(c);
              return _ToggleChip(label: c, selected: sel,
                  onTap: () => controller.toggleColor(c));
            }).toList(),
          )),

          const SizedBox(height: 20),
          _SectionDivider(label: 'Appearance & Sizing'),
          const SizedBox(height: 4),
          Text('Helps us recommend what suits you best.',
              style: AppTextStyles.bodySmall),
          const SizedBox(height: 16),

          // Hair color
          Text('HAIR COLOR', style: AppTextStyles.caption),
          const SizedBox(height: 8),
          Obx(() => Wrap(
            spacing: 8, runSpacing: 8,
            children: controller.hairOptions.map((h) {
              final sel = controller.selectedHair.value == h;
              return _ToggleChip(label: h, selected: sel,
                  onTap: () => controller.selectedHair.value = h);
            }).toList(),
          )),
          const SizedBox(height: 16),

          // Eye color
          Text('EYE COLOR', style: AppTextStyles.caption),
          const SizedBox(height: 8),
          Obx(() => Wrap(
            spacing: 8, runSpacing: 8,
            children: controller.eyeOptions.map((e) {
              final sel = controller.selectedEye.value == e;
              return _ToggleChip(label: e, selected: sel,
                  onTap: () => controller.selectedEye.value = e);
            }).toList(),
          )),
          const SizedBox(height: 16),

          // Skin tone
          Text('SKIN TONE', style: AppTextStyles.caption),
          const SizedBox(height: 8),
          Obx(() => Wrap(
            spacing: 8, runSpacing: 8,
            children: controller.skinOptions.map((s) {
              final sel = controller.selectedSkin.value == s;
              return _ToggleChip(label: s, selected: sel,
                  onTap: () => controller.selectedSkin.value = s);
            }).toList(),
          )),
          const SizedBox(height: 16),

          // Height
          Text('HEIGHT (CM)', style: AppTextStyles.caption),
          const SizedBox(height: 8),
          _EditField(label: '', controller: controller.heightController,
              keyboardType: TextInputType.number, showLabel: false),
          const SizedBox(height: 16),

          // Clothing size
          Text('CLOTHING SIZE', style: AppTextStyles.caption),
          const SizedBox(height: 8),
          Obx(() => Row(
            children: controller.sizeOptions.map((s) {
              final sel = controller.selectedSize.value == s;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => controller.selectedSize.value = s,
                  child: Container(
                    width: 44, height: 44,
                    decoration: BoxDecoration(
                      color: sel ? AppColors.primary : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: sel ? AppColors.primary : AppColors.border),
                    ),
                    child: Center(
                      child: Text(s,
                          style: AppTextStyles.labelMedium.copyWith(
                              color: sel ? Colors.white : AppColors.textPrimary)),
                    ),
                  ),
                ),
              );
            }).toList(),
          )),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _SectionDivider extends StatelessWidget {
  final String label;
  const _SectionDivider({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(label,
        style: AppTextStyles.headlineSmall.copyWith(fontSize: 16));
  }
}

class _EditField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int maxLines;
  final TextInputType? keyboardType;
  final bool showLabel;

  const _EditField({
    required this.label,
    required this.controller,
    this.maxLines = 1,
    this.keyboardType,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showLabel && label.isNotEmpty) ...[
            Text(label, style: AppTextStyles.caption),
            const SizedBox(height: 6),
          ],
          TextFormField(
            controller: controller,
            maxLines: maxLines,
            keyboardType: keyboardType,
            style: AppTextStyles.bodyMedium,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                    color: AppColors.primary, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ToggleChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _ToggleChip({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: selected ? AppColors.primary : AppColors.border),
        ),
        child: Text(label,
            style: AppTextStyles.labelSmall.copyWith(
                color: selected ? Colors.white : AppColors.textPrimary)),
      ),
    );
  }
}