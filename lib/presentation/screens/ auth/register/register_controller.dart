import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';

class RegisterController extends GetxController {
  final emailController = TextEditingController();
  final dobController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final isLoading = false.obs;
  final isPasswordVisible = false.obs;
  final agreedToTerms = false.obs;
  final selectedGender = 'Female'.obs;

  final genderOptions = ['Female', 'Male', 'Non-binary', 'Prefer not to say'];

  @override
  void onClose() {
    emailController.dispose();
    dobController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() => isPasswordVisible.toggle();
  void toggleTerms() => agreedToTerms.toggle();
  void setGender(String gender) => selectedGender.value = gender;

  Future<void> onRegister() async {
    if (!formKey.currentState!.validate()) return;
    if (!agreedToTerms.value) {
      Get.snackbar('Terms Required', 'Please agree to the Terms & Service',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.orange.shade700,
          colorText: Colors.white);
      return;
    }

    isLoading.value = true;
    try {
      await Future.delayed(const Duration(seconds: 1));
      Get.toNamed(AppRoutes.verify,
          arguments: {'email': emailController.text});
    } finally {
      isLoading.value = false;
    }
  }

  void onLogin() => Get.toNamed(AppRoutes.login);

  String? validateEmail(String? v) {
    if (v == null || v.isEmpty) return 'Email is required';
    if (!GetUtils.isEmail(v)) return 'Enter a valid email';
    return null;
  }

  String? validatePassword(String? v) {
    if (v == null || v.isEmpty) return 'Password is required';
    if (v.length < 6) return 'Minimum 6 characters';
    return null;
  }

  String? validateDob(String? v) {
    if (v == null || v.isEmpty) return 'Date of birth is required';
    return null;
  }
}