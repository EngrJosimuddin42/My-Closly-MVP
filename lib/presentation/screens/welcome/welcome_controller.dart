import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/constants/app_constants.dart';
import '../../../routes/app_routes.dart';

class WelcomeController extends GetxController {
  final _storage = GetStorage();

  void onStartExploring() {
    _storage.write(AppConstants.keyOnboarded, true);
    Get.offAllNamed(AppRoutes.main);
  }
}