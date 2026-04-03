import 'package:get/get.dart';

import '../../../../domain/entities/product_entity.dart';
import '../../../../routes/app_routes.dart';
class WardrobeController extends GetxController {
  final recentlyAdded = <ClothingItemEntity>[].obs;

  void onPhotoScan() {
    Get.toNamed(AppRoutes.scanner);
  }

  void onAddManually() {
    Get.toNamed(AppRoutes.scanner);
  }

  void onContinueToScan() {
    Get.toNamed(AppRoutes.scanner);
  }

  void onSkip() {
    Get.offNamed(AppRoutes.welcome);
  }

  void addItem(ClothingItemEntity item) {
    recentlyAdded.insert(0, item);
  }
}