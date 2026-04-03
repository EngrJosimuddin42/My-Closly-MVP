import 'package:get/get.dart';
import 'wardrobe_controller.dart';

class WardrobeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WardrobeController>(() => WardrobeController());
  }
}
