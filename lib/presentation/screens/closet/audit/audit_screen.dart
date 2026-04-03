import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../closet_controller.dart';
import '../../../../routes/app_routes.dart';

class AuditScreen extends StatelessWidget {
  const AuditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Back
            GestureDetector(
              onTap: Get.back,
              child: Row(children: [
                const Icon(Icons.arrow_back_ios_new, size: 16),
                const SizedBox(width: 6),
                Text('Back', style: AppTextStyles.bodyMedium),
              ]),
            ),
            const SizedBox(height: 6),
            Text('WARDROBE AUDIT · MARCH 2026', style: AppTextStyles.caption.copyWith(color: AppColors.textTertiary)),
            const SizedBox(height: 8),
            Text("Your Clothes\nCabinet", style: AppTextStyles.displayMedium.copyWith(height: 1.2)),
            Text('Statistics · 18 Positive Improvements', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textTertiary)),
            const SizedBox(height: 20),

            // Stats row
            Row(children: [
              _AuditStat(value: '21', label: 'TOTAL PIECES'),
              _AuditStat(value: '9',  label: 'ITEMS WORN'),
              _AuditStat(value: '-€290', label: '', isNegative: true),
            ]),
            const SizedBox(height: 20),

            // Cost per wear analysis
            Text('COST PER WEAR — ITEMS TOP PICKED', style: AppTextStyles.caption.copyWith(letterSpacing: 0.6, color: AppColors.textTertiary)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  _CostRow(label: 'Linen Blazer', value: 1.20),
                  _CostRow(label: 'White Tee',    value: 0.90),
                  _CostRow(label: 'Black Trousers',value: 2.20),
                  _CostRow(label: 'Leather Tote', value: 0.44),
                  _CostRow(label: 'Item Top',     value: 0.29),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Ghost pieces notice
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.divider),
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  const Icon(Icons.warning_amber_outlined, color: Color(0xFFD4956A), size: 18),
                  const SizedBox(width: 8),
                  Text('9 Ghost Pieces — 0 wears in 90+ days', style: AppTextStyles.labelMedium),
                ]),
                const SizedBox(height: 6),
                Text('These items sat flat in the on the closet — consider selling the other side of the platform.', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textTertiary)),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.closetGhostPieces),
                  child: Text('€295 Select Items →', style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary)),
                ),
              ]),
            ),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Row(children: [
                const Icon(Icons.trending_up, color: AppColors.success, size: 18),
                const SizedBox(width: 10),
                Expanded(child: Text('−11 kg carbon footprint saved · 8+ sold items', style: AppTextStyles.bodySmall)),
              ]),
            ),
            const SizedBox(height: 20),

            // Start audit button
            GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.closetAuditDetail),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border),
                ),
                child: Center(child: Text('Start Another Audit →', style: AppTextStyles.button.copyWith(color: AppColors.primary))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AuditStat extends StatelessWidget {
  final String value, label;
  final bool isNegative;
  const _AuditStat({required this.value, required this.label, this.isNegative = false});

  @override
  Widget build(BuildContext context) => Expanded(
    child: Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(value, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: isNegative ? AppColors.error : AppColors.textPrimary)),
        Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.textTertiary)),
      ]),
    ),
  );
}

class _CostRow extends StatelessWidget {
  final String label;
  final double value;
  const _CostRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(children: [
      Expanded(child: Text(label, style: AppTextStyles.bodySmall)),
      SizedBox(
        width: 120,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: value / 3,
            backgroundColor: AppColors.divider,
            valueColor: const AlwaysStoppedAnimation(AppColors.primary),
            minHeight: 6,
          ),
        ),
      ),
      const SizedBox(width: 8),
      Text('€${value.toStringAsFixed(2)}', style: AppTextStyles.labelSmall),
    ]),
  );
}