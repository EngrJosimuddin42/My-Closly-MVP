import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../routes/app_routes.dart';

class VerifyController extends GetxController {
  final otpController = TextEditingController();
  final enteredOtp = ''.obs;
  final isLoading = false.obs;
  final canResend = false.obs;
  final resendCountdown = AppConstants.otpResendSeconds.obs;

  Timer? _timer;

  String get email => Get.arguments?['email'] ?? 'your email';

  @override
  void onInit() {
    super.onInit();
    _startResendTimer();
  }

  @override
  void onClose() {
    otpController.dispose();
    _timer?.cancel();
    super.onClose();
  }

  void _startResendTimer() {
    canResend.value = false;
    resendCountdown.value = AppConstants.otpResendSeconds;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (resendCountdown.value > 0) {
        resendCountdown.value--;
      } else {
        canResend.value = true;
        t.cancel();
      }
    });
  }

  void onOtpChanged(String value) {
    enteredOtp.value = value;
  }

  Future<void> onVerify() async {
    if (enteredOtp.value.length < AppConstants.otpLength) {
      Get.snackbar('Invalid', 'Please enter the 4-digit code',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.orange.shade700,
          colorText: Colors.white);
      return;
    }

    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      // Navigate to onboarding
      Get.offNamed(AppRoutes.onboarding);
    } finally {
      isLoading.value = false;
    }
  }

  void onResend() {
    if (!canResend.value) return;
    _startResendTimer();
    Get.snackbar('Code Sent', 'A new code has been sent to $email',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.primary,
        colorText: Colors.white);
  }

  String get formattedCountdown {
    final m = resendCountdown.value ~/ 60;
    final s = resendCountdown.value % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
}