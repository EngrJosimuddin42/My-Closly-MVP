// closet_points_binding.dart
import 'package:get/get.dart';
import 'closet_points_controller.dart';

class ClosetPointsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClosetPointsController>(() => ClosetPointsController());
  }
}