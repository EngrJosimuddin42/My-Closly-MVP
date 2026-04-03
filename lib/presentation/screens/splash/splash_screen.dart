import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller directly get করি — lazyPut কাজ না করলেও এটা force করবে
    final controller = Get.find<SplashController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            _BrandLogo(),
            const SizedBox(height: 32),
            Container(
              width: 60,
              height: 1.5,
              color: AppColors.accent.withOpacity(0.6),
            ),
            const SizedBox(height: 20),
            Text(
              'The social circle',
              style: AppTextStyles.splashTagline,
            ),
            Text(
              'of shopping.',
              style: AppTextStyles.splashTagline,
            ),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}

class _BrandLogo extends StatefulWidget {
  @override
  State<_BrandLogo> createState() => _BrandLogoState();
}

class _BrandLogoState extends State<_BrandLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnim,
      child: SlideTransition(
        position: _slideAnim,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'my',
              style: AppTextStyles.splashBrand.copyWith(fontSize: 32),
            ),
            Text(
              'Closly.',
              style: AppTextStyles.splashBrand,
            ),
          ],
        ),
      ),
    );
  }
}