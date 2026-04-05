import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class StartController extends GetxController {
  VideoPlayerController? videoController;
  final isVideoReady = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initVideo();
  }

  Future<void> _initVideo() async {
    try {
      videoController = VideoPlayerController.asset(
        'assets/videos/fashion_bg.mp4',
      );
      await videoController!.initialize();
      await videoController!.setLooping(true);
      await videoController!.setVolume(0.0);
      await videoController!.play();
      isVideoReady.value = true;
    } catch (e) {
      debugPrint('❌ Video error: $e');
    }
  }

  @override
  void onClose() {
    videoController?.dispose();
    super.onClose();
  }

  void onCreateAccount() => Get.toNamed('/register');
  void onLogin() => Get.toNamed('/login');
}