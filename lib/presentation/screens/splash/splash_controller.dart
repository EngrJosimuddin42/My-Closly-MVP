import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../routes/app_routes.dart';

class SplashController extends GetxController {
  final _storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _initAndNavigate();
  }

  Future<void> _initAndNavigate() async {
    final token = _storage.read<String>(AppConstants.keyToken);
    final isOnboarded =
        _storage.read<bool>(AppConstants.keyOnboarded) ?? false;

    debugPrint('Token: $token | isOnboarded: $isOnboarded');

    await Future.delayed(const Duration(milliseconds: 3000));

    if (token != null && isOnboarded) {
      Get.offAllNamed(AppRoutes.main);
    } else {
      Get.offAllNamed(AppRoutes.start);
    }
  }
}