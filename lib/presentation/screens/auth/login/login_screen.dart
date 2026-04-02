import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../widgets/app_widgets.dart';
import 'login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // ── Background
          Positioned.fill(child: _buildBackground()),

          // ── Header text
          Positioned(
            left: 28,
            right: 28,
            top: topPadding + 56,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome back',
                    style: AppTextStyles.labelMedium
                        .copyWith(color: Colors.white70)),
                const SizedBox(height: 6),
                Text('Log in to',
                    style: AppTextStyles.displayMediumWhite),
                Row(
                  children: [
                    Text(
                      'your profile',
                      style: AppTextStyles.displayItalicWhite
                          .copyWith(color: const Color(0xFFCFAB7A)),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward,
                        color: Color(0xFFCFAB7A), size: 24),
                  ],
                ),
                const SizedBox(height: 10),
                Text(AppStrings.buildFeed,
                    style: AppTextStyles.bodyMediumWhite),
              ],
            ),
          ),

          // ── Back button
          Positioned(
            top: topPadding + 8,
            left: 24,
            child: GestureDetector(
              onTap: Get.back,
              child: const Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 20),
            ),
          ),

          // ── Login sheet pinned to bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: screenHeight * 0.65,
              ),
              child: _LoginSheet(),
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
        opacity: 0.5,
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

// ─── Login Sheet
class _LoginSheet extends GetView<LoginController> {
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
          24, 32, 24,
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
              const SizedBox(height: 14),

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

              // Remember me & Forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: (_) =>
                              controller.toggleRememberMe(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(AppStrings.rememberMe,
                          style: AppTextStyles.bodySmall),
                    ],
                  )),
                  GestureDetector(
                    onTap: controller.onForgotPassword,
                    child: Text(
                      AppStrings.forgotPassword,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),

              // Continue button
              Obx(() => AppPrimaryButton(
                label: AppStrings.continueBtn,
                onTap: controller.onLogin,
                isLoading: controller.isLoading.value,
              )),
              const SizedBox(height: 22),

              // Social login
              const SocialLoginRow(),
              const SizedBox(height: 18),

              // Sign up link
              Center(
                child: GestureDetector(
                  onTap: controller.onSignUp,
                  child: RichText(
                    text: TextSpan(
                      style: AppTextStyles.bodySmall,
                      children: [
                        TextSpan(text: '${AppStrings.noAccount} '),
                        TextSpan(
                          text: AppStrings.signUp,
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