import 'package:get/get.dart';
import 'start_controller.dart';

class StartBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<StartController>()) {
      Get.put<StartController>(StartController());
    }
  }
}