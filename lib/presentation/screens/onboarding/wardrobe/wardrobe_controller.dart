import 'package:get/get.dart';
import '../../../../domain/entities/product_entity.dart';
import '../../../../routes/app_routes.dart';


class WardrobeController extends GetxController {
  final recentlyAdded = <ClothingItemEntity>[].obs;

  bool get hasItems => recentlyAdded.isNotEmpty;

  // Photo Scan → Scanner (scanning state — default)
  void onPhotoScan() {
    Get.toNamed(AppRoutes.scanner);
  }

  // Add Manually → Scanner (manual state directly)
  void onAddManually() {
    Get.toNamed(AppRoutes.scanner, arguments: {'openManual': true});
  }

  void onFinish() {
    Get.offNamed(AppRoutes.welcome);
  }

  void onSkip() {
    Get.offNamed(AppRoutes.welcome);
  }

  void addItem(ClothingItemEntity item) {
    recentlyAdded.insert(0, item);
  }
}