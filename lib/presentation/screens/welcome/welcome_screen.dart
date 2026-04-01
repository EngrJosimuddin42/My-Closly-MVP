import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import 'welcome_controller.dart';

class WelcomeScreen extends GetView<WelcomeController> {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background
          Container(
            color: const Color(0xFF5A4A42),
            child: Opacity(
              opacity: 0.5,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=600'),
                  ),
                ),
              ),
            ),
          ),

          // Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.4),
                  Colors.black.withOpacity(0.7),
                ],
                stops: const [0.3, 0.6, 1.0],
              ),
            ),
          ),

          // Brand overlay top-left
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('my',
                          style: AppTextStyles.headlineMedium
                              .copyWith(color: Colors.white, fontSize: 16)),
                      Text('Closly.',
                          style: AppTextStyles.displaySmall
                              .copyWith(color: Colors.white)),
                    ],
                  ),
                  const Spacer(),

                  // Welcome message
                  Text("You're all set,",
                      style: AppTextStyles.bodyLargeWhite.copyWith(
                          color: Colors.white70)),
                  const SizedBox(height: 4),
                  Text('Sarah, Welcome.',
                      style: AppTextStyles.displayMediumWhite.copyWith(
                          fontSize: 40)),
                  const SizedBox(height: 16),

                  // Profile card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Style badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColors.accent.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 7,
                                height: 7,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.accent,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text('Refined Minimal. AI analysed',
                                  style: AppTextStyles.caption.copyWith(
                                      color: Colors.white)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Stats grid
                        Row(
                          children: [
                            _StatItem(label: 'LOCATION', value: 'München DE'),
                            _StatItem(label: 'SIZE', value: 'S - 168 cm'),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            _StatItem(label: 'EYE COLOUR', value: 'Brown'),
                            _StatItem(label: 'FAV BRANDS', value: 'COS · Arket'),
                          ],
                        ),
                        const SizedBox(height: 14),
                        // Interest tags
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: ['Tech', 'Art', 'Yoga', 'Travel', 'Contemporary']
                              .map((tag) => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.2)),
                            ),
                            child: Text(tag,
                                style: AppTextStyles.caption
                                    .copyWith(color: Colors.white)),
                          ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Start button
                  GestureDetector(
                    onTap: controller.onStartExploring,
                    child: Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          'Start Exploring',
                          style: AppTextStyles.button
                              .copyWith(color: AppColors.primary),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: AppTextStyles.caption.copyWith(
                  color: Colors.white54, letterSpacing: 0.8)),
          const SizedBox(height: 2),
          Text(value,
              style: AppTextStyles.labelMedium.copyWith(color: Colors.white)),
        ],
      ),
    );
  }
}