import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
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
          Obx(() => _buildVideoBackground()),

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
                  _buildTitle(),
                  const SizedBox(height: 12),
                  Text(
                    AppStrings.aiTagline,
                    style: AppTextStyles.bodyMediumWhite,
                  ),
                  const SizedBox(height: 48),
                  _CreateAccountButton(onTap: controller.onCreateAccount),
                  const SizedBox(height: 20),
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

  Widget _buildVideoBackground() {
    final vc = controller.videoController;

    if (controller.isVideoReady.value &&
        vc != null &&
        vc.value.isInitialized) {
      return SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: vc.value.size.width,
            height: vc.value.size.height,
            child: VideoPlayer(vc),
          ),
        ),
      );
    }
    return Container(color: AppColors.background);
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.landingTitle, style: AppTextStyles.displayLargeWhite),
        Text(
          AppStrings.landingTitleItalic,
          style: AppTextStyles.displayItalicLarge),
        Text(AppStrings.landingTitleEnd,
            style: AppTextStyles.displayLargeWhite),
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
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            AppStrings.createAccount,
            style: AppTextStyles.button.copyWith(
              color: AppColors.textOnDarkSecondary,
              fontSize: 20,
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
                fontSize: 15,
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.textOnDark,
              ),
              child: const Icon(
                Icons.arrow_forward,
                color: AppColors.textOnDarkSecondary,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}