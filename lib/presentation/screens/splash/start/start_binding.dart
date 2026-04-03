import 'package:get/get.dart';
import 'start_controller.dart';

class StartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StartController>(() => StartController());
  }
}