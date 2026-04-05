import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../widgets/app_widgets.dart';
import 'verify_controller.dart';

class VerifyScreen extends GetView<VerifyController> {
  const VerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          _buildBackground(),
          Positioned(
            left: 28,
            top: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Last step', style: AppTextStyles.labelMedium.copyWith(fontSize: 16)),
                const SizedBox(height: 16),
                Text('Verify your',
                    style: AppTextStyles.displayMedium.copyWith(
                        fontWeight: FontWeight.w500, color: AppColors.textOnDark)),
                Row(
                  children: [
                    Text('Account',
                        style: AppTextStyles.displayItalic.copyWith(
                            fontWeight: FontWeight.w500, color: Colors.white)),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward, color: AppColors.accent, size: 24),
                  ],
                ),
                const SizedBox(height: 12),
                Text(AppStrings.buildFeed,
                    style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textOnDark)),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _VerifySheet(),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset('assets/images/background.png', fit: BoxFit.cover),
        Container(color: Colors.black.withValues(alpha: 0.2)),
      ],
    );
  }
}

class _VerifySheet extends GetView<VerifyController> {
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Container(
            width: 72,
            height: 72,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))],
            ),
            child: const Icon(Icons.mail_outline, color: AppColors.textOnDarkSecondary, size: 32),
          ),
          const SizedBox(height: 24),

          Text(AppStrings.sentCode, style: AppTextStyles.headlineMedium, textAlign: TextAlign.center),
          RichText(
            text: TextSpan(
              style: AppTextStyles.headlineMedium.copyWith(fontWeight: FontWeight.w400),
              children: [
                const TextSpan(text: 'to your '),
                TextSpan(text: 'email.', style: AppTextStyles.displayItalicSmall),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(AppStrings.enterCode,
              style: AppTextStyles.bodySmall.copyWith(fontSize: 14, color: AppColors.textPrimary2)),
          const SizedBox(height: 24),

          _OtpFields(),
          const SizedBox(height: 32),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Obx(() => AppPrimaryButton(
                  label: AppStrings.verifyBtn,
                  onTap: controller.onVerify,
                  isLoading: controller.isLoading.value,
                )),
                const SizedBox(height: 20),
                _buildResendSection(),
                SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResendSection() {
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(AppStrings.sendCodeAgain,
            style: AppTextStyles.bodySmall.copyWith(
              color: controller.canResend.value ? AppColors.accent : AppColors.textTertiary,
            )),
        const SizedBox(width: 6),
        if (!controller.canResend.value)
          Text(controller.formattedCountdown,
              style: AppTextStyles.labelMedium.copyWith(color: AppColors.textPrimary))
        else
          GestureDetector(
            onTap: controller.onResend,
            child: Text('Resend',
                style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary)),
          ),
      ],
    ));
  }
}

class _OtpFields extends GetView<VerifyController> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: Opacity(
            opacity: 0,
            child: TextField(
              controller: controller.otpController,
              focusNode: controller.focusNode,
              onChanged: (value) => controller.onOtpChanged(value),
              keyboardType: TextInputType.number,
              maxLength: AppConstants.otpLength,
              autofocus: true,
              decoration: const InputDecoration(
                counterText: "",
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            controller.requestFocus();
          },
          behavior: HitTestBehavior.translucent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(AppConstants.otpLength, (i) {
              return Obx(() {
                final otp = controller.enteredOtp.value;
                final hasValue = i < otp.length;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: 62,
                  height: 68,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: hasValue ? AppColors.primary : AppColors.border,
                      width: hasValue ? 1.5 : 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      hasValue ? otp[i] : '',
                      style: AppTextStyles.displaySmall.copyWith(fontSize: 24),
                    ),
                  ),
                );
              });
            }),
          ),
        ),
      ],
    );
  }
}