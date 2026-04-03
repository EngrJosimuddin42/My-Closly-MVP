import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'start_controller.dart';

class StartScreen extends GetView<StartController> {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image placeholder (fashion photo)
          _buildBackground(),

          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.2),
                  Colors.black.withValues(alpha: 0.6),
                ],
                stops: const [0.3, 0.6, 1.0],
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(flex: 3),

                  // Title
                  _buildTitle(),

                  const SizedBox(height: 12),

                  // Subtitle
                  Text(
                    AppStrings.aiTagline,
                    style: AppTextStyles.bodyMediumWhite,
                  ),

                  const SizedBox(height: 48),

                  // Create Account Button
                  _CreateAccountButton(onTap: controller.onCreateAccount),

                  const SizedBox(height: 20),

                  // Already have account
                  _LoginLink(onTap: controller.onLogin),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      color: const Color(0xFF8A7B6F),
      child: Center(
        child: Icon(
          Icons.person_outline,
          size: 200,
          color: Colors.white.withValues(alpha: 0.1),
        ),
      ),
    );
    // In production: use CachedNetworkImage or AssetImage
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.landingTitle, style: AppTextStyles.displayLargeWhite),
        Text(
          AppStrings.landingTitleItalic,
          style: AppTextStyles.displayItalicLarge.copyWith(
            color: const Color(0xFFCFAB7A),
          ),
        ),
        Text(AppStrings.landingTitleEnd, style: AppTextStyles.displayLargeWhite),
      ],
    );
  }
}

class _CreateAccountButton extends StatelessWidget {
  final VoidCallback onTap;
  const _CreateAccountButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            AppStrings.createAccount,
            style: AppTextStyles.button.copyWith(
              color: AppColors.primary,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginLink extends StatelessWidget {
  final VoidCallback onTap;
  const _LoginLink({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.alreadyHaveAccount,
              style: AppTextStyles.bodyMediumWhite.copyWith(
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
              ),
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}