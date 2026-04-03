import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../routes/app_routes.dart';

class SettingsController extends GetxController {
  final _storage = GetStorage();

  // User info (passed from profile)
  final userName    = 'Sarah Picker'.obs;
  final userHandle  = '@sarah_myReady'.obs;
  final styleTag    = 'Refined Minimal · 1,250 pts'.obs;

  void onPrivacySecurity()    => Get.snackbar('Privacy', 'Coming soon', snackPosition: SnackPosition.TOP);
  void onHelpSupport()        => Get.snackbar('Help', 'Coming soon',    snackPosition: SnackPosition.TOP);
  void onInformationLegal()   => Get.snackbar('Legal', 'Coming soon',   snackPosition: SnackPosition.TOP);

  void onLogOut() {
    _storage.remove(AppConstants.keyToken);
    _storage.remove(AppConstants.keyOnboarded);
    Get.offAllNamed(AppRoutes.start);
  }
}