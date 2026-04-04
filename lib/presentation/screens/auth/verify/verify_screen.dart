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
          SafeArea(
            child: Column(
              children: [
                const Expanded(child: SizedBox()),
                _VerifySheet(),
              ],
            ),
          ),
          Positioned(
            left: 28,
            top: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Last step', style: AppTextStyles.labelMedium.copyWith(color: Colors.white70)),
                const SizedBox(height: 6),
                Text('Verify your', style: AppTextStyles.displayMediumWhite),
                Row(
                  children: [
                    Text(
                      'Account',
                      style: AppTextStyles.displayItalicWhite.copyWith(color: const Color(0xFFCFAB7A)),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward, color: Color(0xFFCFAB7A), size: 24),
                  ],
                ),
                const SizedBox(height: 10),
                Text(AppStrings.buildFeed, style: AppTextStyles.bodyMediumWhite),
              ],
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
              image: NetworkImage('https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=600'),
            ),
          ),
        ),
      ),
    );
  }
}

class _VerifySheet extends GetView<VerifyController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24), // প্যাডিং কিছুটা কমানো হয়েছে
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      // এখানে মূল পরিবর্তন: Column-কে SingleChildScrollView দিয়ে র‍্যাপ করা হয়েছে
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min, // এটি কলামকে যতটুকু দরকার ততটুকু জায়গা নিতে বলবে
          children: [
            // Mail icon
            Container(
              width: 72,
              height: 72,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [BoxShadow(color: Color(0x12000000), blurRadius: 20, offset: Offset(0, 4))],
              ),
              child: const Icon(Icons.mail_outline, color: AppColors.primary, size: 32),
            ),
            const SizedBox(height: 24),

            // Message
            Text(
              AppStrings.sentCode,
              style: AppTextStyles.headlineMedium,
              textAlign: TextAlign.center,
            ),
            RichText(
              text: TextSpan(
                style: AppTextStyles.headlineMedium,
                children: [
                  const TextSpan(text: 'to your '),
                  TextSpan(
                    text: 'email.',
                    style: AppTextStyles.displayItalicSmall.copyWith(
                      fontSize: 20,
                      color: AppColors.accent,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              AppStrings.enterCode,
              style: AppTextStyles.bodySmall.copyWith(color: const Color(0xFF6B9BC4)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24), // গ্যাপ একটু কমানো হয়েছে

            // OTP Fields
            _OtpFields(),
            const SizedBox(height: 28),

            // Verify button
            Obx(() => AppPrimaryButton(
              label: AppStrings.verifyBtn,
              onTap: controller.onVerify,
              isLoading: controller.isLoading.value,
            )),
            const SizedBox(height: 20),

            // Resend
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppStrings.sendCodeAgain,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: controller.canResend.value
                          ? AppColors.primary
                          : AppColors.textTertiary,
                    )),
                const SizedBox(width: 6),
                if (!controller.canResend.value)
                  Text(
                    controller.formattedCountdown,
                    style: AppTextStyles.labelMedium.copyWith(color: AppColors.textPrimary),
                  )
                else
                  GestureDetector(
                    onTap: controller.onResend,
                    child: Text('Resend',
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.primary,
                          decoration: TextDecoration.underline,
                        )),
                  ),
              ],
            )),
          ],
        ),
      ),
    );
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