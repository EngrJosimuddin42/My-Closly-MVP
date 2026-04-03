import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../widgets/app_widgets.dart';
import 'register_controller.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // ── Background full screen ──────────────────────────────
          Positioned.fill(child: _buildBackground()),

          // ── Header text ─────────────────────────────────────────
          Positioned(
            left: 28,
            right: 28,
            top: topPadding + 56,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Now here..',
                    style: AppTextStyles.labelMedium
                        .copyWith(color: Colors.white70)),
                const SizedBox(height: 6),
                Text(AppStrings.createTitle,
                    style: AppTextStyles.displayMediumWhite),
                Row(
                  children: [
                    Text(AppStrings.createTitleItalic,
                        style: AppTextStyles.displayItalicWhite
                            .copyWith(color: const Color(0xFFCFAB7A))),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward,
                        color: Color(0xFFCFAB7A), size: 24),
                  ],
                ),
                const SizedBox(height: 8),
                Text(AppStrings.buildFeed,
                    style: AppTextStyles.bodyMediumWhite),
              ],
            ),
          ),
          // ── Bottom sheet pinned to bottom ───────────────────────
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            // max height = 72% of screen
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: screenHeight * 0.72,
              ),
              child: _RegisterSheet(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      color: const Color(0xFF5A4A42),
      child: Opacity(
        opacity: 0.55,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=600',
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Register Sheet ───────────────────────────────────────────────
class _RegisterSheet extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.fromLTRB(
          24, 28, 24,
          MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Email
              AppTextField(
                label: AppStrings.emailLabel,
                hint: AppStrings.emailHint,
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                validator: controller.validateEmail,
                prefixIcon: const Icon(Icons.mail_outline,
                    color: AppColors.textTertiary, size: 18),
              ),
              const SizedBox(height: 12),

              // DOB + Gender row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Date of Birth', style: AppTextStyles.labelMedium),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () => controller.pickDate(context),
                          child: Obx(() => Container(
                            height: 52,
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppColors.inputBorder),
                            ),
                            child: Row(children: [
                              const Icon(Icons.calendar_today_outlined,
                                  color: AppColors.textTertiary, size: 16),
                              const SizedBox(width: 8),
                              Text(
                                controller.selectedDate.value == null
                                    ? 'MM/DD/YY'
                                    : controller.dobController.text,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: controller.selectedDate.value == null
                                      ? AppColors.textTertiary
                                      : AppColors.textPrimary,
                                ),
                              ),
                            ]),
                          )),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppStrings.genderLabel,
                            style: AppTextStyles.labelMedium),
                        const SizedBox(height: 8),
                        Obx(() => Container(
                          height: 52,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.circular(16),
                            border: Border.all(
                                color: AppColors.inputBorder),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: controller.selectedGender.value,
                              isExpanded: true,
                              items: controller.genderOptions
                                  .map((g) => DropdownMenuItem(
                                value: g,
                                child: Text(g,
                                    style: AppTextStyles
                                        .bodyMedium
                                        .copyWith(fontSize: 13)),
                              ))
                                  .toList(),
                              onChanged: (v) =>
                                  controller.setGender(v!),
                              icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: AppColors.textTertiary,
                                  size: 18),
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Password
              Obx(() => AppTextField(
                label: AppStrings.passwordLabel,
                hint: AppStrings.passwordHint,
                controller: controller.passwordController,
                obscureText: !controller.isPasswordVisible.value,
                validator: controller.validatePassword,
                prefixIcon: const Icon(Icons.lock_outline,
                    color: AppColors.textTertiary, size: 18),
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.isPasswordVisible.value
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: AppColors.textTertiary,
                    size: 18,
                  ),
                  onPressed: controller.togglePasswordVisibility,
                ),
              )),
              const SizedBox(height: 12),

              // Terms
              Obx(() => GestureDetector(
                onTap: controller.toggleTerms,
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: Checkbox(
                        value: controller.agreedToTerms.value,
                        onChanged: (_) => controller.toggleTerms(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: AppTextStyles.bodySmall,
                          children: const [
                            TextSpan(text: 'I agree to the '),
                            TextSpan(
                              text: 'Terms & Service',
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline),
                            ),
                            TextSpan(text: ' and '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline),
                            ),
                            TextSpan(text: '.'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
              const SizedBox(height: 18),

              // Continue
              Obx(() => AppPrimaryButton(
                label: AppStrings.continueBtn,
                onTap: controller.onRegister,
                isLoading: controller.isLoading.value,
              )),
              const SizedBox(height: 18),

              const SocialLoginRow(),
              const SizedBox(height: 14),

              Center(
                child: GestureDetector(
                  onTap: controller.onLogin,
                  child: RichText(
                    text: TextSpan(
                      style: AppTextStyles.bodySmall,
                      children: [
                        const TextSpan(text: 'Already have an account? '),
                        TextSpan(
                          text: 'Log In',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}