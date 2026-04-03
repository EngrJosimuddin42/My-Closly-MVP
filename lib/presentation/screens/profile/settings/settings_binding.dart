import 'package:get/get.dart';
import 'package:myclosly/presentation/screens/profile/settings/settings_controller.dart';
class SettingsBinding extends Bindings {
  void dependencies() {
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}