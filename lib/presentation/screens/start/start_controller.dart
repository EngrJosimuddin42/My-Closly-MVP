import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class StartController extends GetxController {
  void onCreateAccount() {
    Get.toNamed(AppRoutes.register);
  }

  void onLogin() {
    Get.toNamed(AppRoutes.login);
  }
}