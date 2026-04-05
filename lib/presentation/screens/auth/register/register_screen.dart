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
                    style: AppTextStyles.labelMedium.copyWith(fontSize: 16)),
                const SizedBox(height: 12),
                Text(AppStrings.createTitle,style: AppTextStyles.displayMedium.copyWith(fontWeight: FontWeight.w400,color: AppColors.textOnDark)),
                Row(
                  children: [
                    Text(AppStrings.createTitleItalic,
                        style: AppTextStyles.displayItalic.copyWith(fontWeight: FontWeight.w500)),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward,
                        color:AppColors.accent, size: 24),
                  ],
                ),
                const SizedBox(height: 12),
                Text(AppStrings.buildFeed,
                    style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textOnDark)),
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
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/background.png',
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withValues(alpha: 0.1),
        ),
      ],
    );
  }
}

// ─── Register Sheet ───────────────────────────────────────────────
class _RegisterSheet extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.6],
          colors: [
            Colors.white.withValues(alpha: 0.0),
            AppColors.background,
          ],
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
                    color: AppColors.accent, size: 18),
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
                              Image.asset('assets/icons/calendar.png',
                                color: AppColors.accent,
                                width: 16,
                                height: 16,
                                fit: BoxFit.contain,
                              ),
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
                prefixIcon:
                Image.asset(
                  'assets/icons/lock.png',
                  width: 18,
                  height: 18,
                  color: AppColors.accent,
                ),
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
                        side: const BorderSide(color:AppColors.accent),
                        activeColor: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 10),
                     Expanded(
                      child: Text(
                        'I agree to the Terms & Service and Privacy Policy.',
                        style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textOnDarkSecondary),
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