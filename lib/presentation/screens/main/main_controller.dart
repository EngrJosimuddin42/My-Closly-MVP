import 'package:get/get.dart';

class MainController extends GetxController {
  // 0=Home, 1=Message, 2=Closet, 3=Profile
  final currentIndex = 0.obs;

  void onNavTap(int index) {
    currentIndex.value = index;
  }
}