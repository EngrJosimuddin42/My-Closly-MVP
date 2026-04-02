import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class MainController extends GetxController {
  // 0=Home, 1=Message, 2=Closet, 3=Profile
  final currentIndex = 0.obs;

  void onNavTap(int index) {
    if (index == 2) {
      // Closet → আলাদা page
      Get.toNamed(AppRoutes.wardrobe);
      return;
    }
    currentIndex.value = index;
  }
}