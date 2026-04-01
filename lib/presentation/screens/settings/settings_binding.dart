import 'package:get/get.dart';
import 'package:myclosly/presentation/screens/settings/settings_controller.dart';
class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}