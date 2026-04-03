import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import 'closet_controller.dart';

class ClosetScreen extends GetView<ClosetController> {
  const ClosetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // ── AppBar ─────────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('my', style: AppTextStyles.caption),
                  Text('Closly.', style: AppTextStyles.headlineLarge.copyWith(height: 0.9)),
                ]),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(children: [
                    const Icon(Icons.visibility_outlined, color: Colors.white, size: 14),
                    const SizedBox(width: 6),
                    Text('Value View', style: AppTextStyles.labelSmall.copyWith(color: Colors.white)),
                  ]),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ── Closet Score Card ──────────────────────────────────
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('CLOSET SCORE', style: AppTextStyles.caption.copyWith(color: AppColors.textTertiary, letterSpacing: 0.8)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() => RichText(text: TextSpan(children: [
                              TextSpan(text: '${controller.closetScore.value}', style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w700, color: AppColors.textPrimary, height: 1)),
                              TextSpan(text: '/${controller.maxScore.value}', style: AppTextStyles.bodyMedium),
                            ]))),
                            const SizedBox(height: 6),
                            Obx(() => ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: controller.closetScore.value / controller.maxScore.value,
                                backgroundColor: AppColors.divider,
                                valueColor: const AlwaysStoppedAnimation(Color(0xFF4A90D9)),
                                minHeight: 6,
                              ),
                            )),
                            const SizedBox(height: 6),
                            Text('Good · above average', style: AppTextStyles.caption.copyWith(color: AppColors.textTertiary)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 64, height: 64,
                            child: Obx(() => CircularProgressIndicator(
                              value: controller.closetScore.value / controller.maxScore.value,
                              backgroundColor: AppColors.divider,
                              color: const Color(0xFF4A90D9),
                              strokeWidth: 6,
                            )),
                          ),
                          Obx(() => Text('${controller.closetScore.value}%',
                              style: AppTextStyles.labelMedium.copyWith(fontSize: 13))),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(10)),
                    child: Text('12 pieces you rarely wear — a sell-off could boost your score', style: AppTextStyles.bodySmall),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(child: _ScoreStat(label: 'Cost / Wear', value: '€2.41')),
                      const SizedBox(width: 12),
                      Expanded(child: _ScoreStat(label: 'Closet Points', value: '1,370')),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ── Wardrobe Intelligence ──────────────────────────────
            Text('WARDROBE INTELLIGENCE', style: AppTextStyles.caption.copyWith(color: AppColors.textTertiary, letterSpacing: 0.8)),
            const SizedBox(height: 12),

            _WardrobeRow(
              icon: Icons.grid_view_outlined,
              title: 'All Pieces',
              subtitle: '${controller.totalPieces} items · Arket & Toteme',
              badge: '${controller.totalPieces}',
              badgeColor: AppColors.primary,
              onTap: controller.onAllPieces,
            ),
            const SizedBox(height: 10),
            _WardrobeRow(
              icon: Icons.warning_amber_outlined,
              title: 'Ghost Pieces',
              subtitle: '${controller.ghostItems.length} items you may no longer need',
              badge: '${controller.ghostItems.length} items',
              badgeColor: const Color(0xFFD4956A),
              onTap: controller.onGhostPieces,
            ),
            const SizedBox(height: 10),
            _WardrobeRow(
              icon: Icons.bar_chart_outlined,
              title: 'Wardrobe Audit',
              subtitle: 'Review your wardrobe health',
              badge: '& tips',
              badgeColor: const Color(0xFF4A90D9),
              onTap: controller.onAudit,
            ),
            const SizedBox(height: 20),

            // ── Add to Closet ──────────────────────────────────────
            Text('ADD TO YOUR CLOSET', style: AppTextStyles.caption.copyWith(color: AppColors.textTertiary, letterSpacing: 0.8)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _AddBtn(icon: Icons.add, label: 'Add Manually', onTap: controller.onAddManually)),
                const SizedBox(width: 12),
                Expanded(child: _AddBtn(icon: Icons.camera_alt_outlined, label: 'Upload Photo', onTap: controller.onUploadPhoto)),
              ],
            ),
            const SizedBox(height: 20),

            // ── Style DNA ──────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('STYLE DNA', style: AppTextStyles.caption.copyWith(color: AppColors.textTertiary, letterSpacing: 0.8)),
                Text('Full report >', style: AppTextStyles.caption.copyWith(color: const Color(0xFF4A90D9))),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
              child: Column(
                children: controller.styleDna.entries.map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      SizedBox(width: 80, child: Text(e.key, style: AppTextStyles.bodySmall)),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: e.value / 100,
                            backgroundColor: AppColors.divider,
                            valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                            minHeight: 5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text('${e.value}%', style: AppTextStyles.caption.copyWith(color: AppColors.textTertiary)),
                    ],
                  ),
                )).toList(),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _ScoreStat extends StatelessWidget {
  final String label, value;
  const _ScoreStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(10)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.textTertiary)),
      const SizedBox(height: 4),
      Text(value, style: AppTextStyles.headlineSmall),
    ]),
  );
}

class _WardrobeRow extends StatelessWidget {
  final IconData icon;
  final String title, subtitle, badge;
  final Color badgeColor;
  final VoidCallback onTap;
  const _WardrobeRow({required this.icon, required this.title, required this.subtitle, required this.badge, required this.badgeColor, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(children: [
        Icon(icon, size: 22, color: AppColors.textSecondary),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: AppTextStyles.labelLarge),
          Text(subtitle, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textTertiary)),
        ])),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: badgeColor.withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
          child: Text(badge, style: AppTextStyles.caption.copyWith(color: badgeColor, fontWeight: FontWeight.w700)),
        ),
      ]),
    ),
  );
}

class _AddBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _AddBtn({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
      child: Column(children: [
        Icon(icon, size: 22, color: AppColors.textSecondary),
        const SizedBox(height: 6),
        Text(label, style: AppTextStyles.bodySmall),
      ]),
    ),
  );
}