import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class ProfileController extends GetxController {
  final selectedTab = 0.obs;
  final showMenu = false.obs;

  final userName   = 'Sarah Picker'.obs;
  final userHandle = '@sarah_mycloset_München'.obs;
  final userBio    = 'Minimal dresser · Tech & Art 🎨'.obs;

  final savedItems = <Map<String, String>>[
    {'brand': 'COS',      'name': 'Linen Blazer',  'price': '€0.80 CPW'},
    {'brand': 'ARKET',    'name': 'White Tee',      'price': '€0.65 CPW'},
    {'brand': 'MANGO',    'name': 'Mini Bag',       'price': '€1.20 CPW'},
    {'brand': 'SUZANE',   'name': 'Leather Tote',   'price': '€1.80 CPW'},
    {'brand': 'TOTEME',   'name': 'Black Trousers', 'price': '€1.10 CPW'},
    {'brand': 'EVERLANE', 'name': 'Loafers',        'price': '€1.50 CPW'},
  ];

  void setTab(int tab) => selectedTab.value = tab;
  void toggleMenu()    => showMenu.toggle();
  void closeMenu()     => showMenu.value = false;

  void onShareProfile()    { closeMenu(); Get.snackbar('Share', 'Profile link copied!', snackPosition: SnackPosition.TOP); }
  void onCopyProfileLink() { closeMenu(); Get.snackbar('Copied', 'Link copied', snackPosition: SnackPosition.TOP); }
  void onInviteFriends()   { closeMenu(); }
  void onFollowersTap()    => Get.toNamed(AppRoutes.followers);

  void onClosetPoints() {
    closeMenu();
    Get.toNamed(AppRoutes.closetPoints);
  }

  void onEditProfile() {
    closeMenu();
    Get.toNamed(AppRoutes.editProfile);
  }

  void onSettings() {
    closeMenu();
    Get.toNamed(AppRoutes.settings);
  }
}