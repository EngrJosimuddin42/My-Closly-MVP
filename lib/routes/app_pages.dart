import 'package:get/get.dart';
import '../presentation/screens/auth/login/login_binding.dart';
import '../presentation/screens/auth/login/login_screen.dart';
import '../presentation/screens/auth/register/register_binding.dart';
import '../presentation/screens/auth/register/register_screen.dart';
import '../presentation/screens/auth/verify/verify_binding.dart';
import '../presentation/screens/auth/verify/verify_screen.dart';
import '../presentation/screens/main/main_binding.dart';
import '../presentation/screens/main/main_screen.dart';
import '../presentation/screens/closet_points/closet_points_binding.dart';
import '../presentation/screens/closet_points/closet_points_screen.dart';
import '../presentation/screens/edit_profile/edit_profile_binding.dart';
import '../presentation/screens/edit_profile/edit_profile_screen.dart';
import '../presentation/screens/followers/followers_binding.dart';
import '../presentation/screens/followers/followers_screen.dart';
import '../presentation/screens/notifications/notifications_binding.dart';
import '../presentation/screens/notifications/notifications_screen.dart';
import '../presentation/screens/onboarding/onboarding_binding.dart';
import '../presentation/screens/profile/profile_binding.dart';
import '../presentation/screens/profile/profile_screen.dart';
import '../presentation/screens/settings/settings_binding.dart';
import '../presentation/screens/settings/settings_screen.dart';
import '../presentation/screens/splash/splash_screen.dart';
import '../presentation/screens/splash/splash_binding.dart';
import '../presentation/screens/onboarding/onboarding_screen.dart';
import '../presentation/screens/scanner/scanner_screen.dart';
import '../presentation/screens/scanner/scanner_binding.dart';
import '../presentation/screens/wardrobe/wardrobe_screen.dart';
import '../presentation/screens/wardrobe/wardrobe_binding.dart';
import '../presentation/screens/welcome/welcome_screen.dart';
import '../presentation/screens/welcome/welcome_binding.dart';
import '../presentation/screens/home/home_screen.dart';
import '../presentation/screens/home/home_binding.dart';
import '../presentation/screens/start/start_screen.dart';
import '../presentation/screens/start/start_binding.dart';
import 'app_routes.dart';

class AppPages {
  static const String initial = AppRoutes.splash;

  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.start,
      page: () => const StartScreen(),
      binding: StartBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 350),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterScreen(),
      binding: RegisterBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 350),
    ),
    GetPage(
      name: AppRoutes.verify,
      page: () => const VerifyScreen(),
      binding: VerifyBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 350),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingScreen(),
      binding: OnboardingBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(name: AppRoutes.main,
        page: () => const MainScreen(),
        binding: MainBinding(),
        transition: Transition.fade
    ),
    GetPage(
      name: AppRoutes.scanner,
      page: () => const ScannerScreen(),
      binding: ScannerBinding(),
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 350),
    ),
    GetPage(
      name: AppRoutes.wardrobe,
      page: () => const WardrobeScreen(),
      binding: WardrobeBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 350),
    ),
    GetPage(
      name: AppRoutes.welcome,
      page: () => const WelcomeScreen(),
      binding: WelcomeBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 600),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(name: AppRoutes.profile,
        page: () => const ProfileScreen(),
        binding: ProfileBinding(), transition: Transition.rightToLeft
    ),
    GetPage(name: AppRoutes.editProfile,
        page: () => const EditProfileScreen(),
        binding: EditProfileBinding(),
        transition: Transition.rightToLeft
    ),
    GetPage(name: AppRoutes.closetPoints,
        page: () => const ClosetPointsScreen(),
        binding: ClosetPointsBinding(), transition: Transition.rightToLeft
    ),
    GetPage(name: AppRoutes.followers,
        page: () => const FollowersScreen(),
        binding: FollowersBinding(), transition: Transition.downToUp
    ),
    GetPage(name: AppRoutes.settings,
        page: () => const SettingsScreen(),
        binding: SettingsBinding(),
        transition: Transition.rightToLeft
    ),
    GetPage(name: AppRoutes.notifications,
        page: () => const NotificationsScreen(),
        binding: NotificationsBinding(),
        transition: Transition.rightToLeft
    ),
  ];
}