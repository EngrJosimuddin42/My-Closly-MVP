import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final isLoading = false.obs;
  final isPasswordVisible = false.obs;
  final rememberMe = false.obs;

  final _storage = GetStorage();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() => isPasswordVisible.toggle();
  void toggleRememberMe() => rememberMe.toggle();

  Future<void> onLogin() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      await Future.delayed(const Duration(seconds: 1));

      _storage.write(AppConstants.keyToken, 'mock_token_12345');
      _storage.write(AppConstants.keyOnboarded, true);

      Get.offAllNamed(AppRoutes.main);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Login failed. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void onSignUp() {
    Get.offNamed(AppRoutes.register);
  }

  void onForgotPassword() {
    // TODO: Navigate to forgot password
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!GetUtils.isEmail(value)) return 'Enter a valid email';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }
}