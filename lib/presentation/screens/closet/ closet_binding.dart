import 'package:get/get.dart';
import 'closet_controller.dart';

class ClosetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClosetController>(() => ClosetController());
  }
}