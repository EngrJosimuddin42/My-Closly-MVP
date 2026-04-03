import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../closet_controller.dart';

class AuditDetailScreen extends StatefulWidget {
  const AuditDetailScreen({super.key});

  @override
  State<AuditDetailScreen> createState() => _AuditDetailScreenState();
}

class _AuditDetailScreenState extends State<AuditDetailScreen> {
  int _currentPage = 0; // 0=detail1, 1=detail2

  void _next()     => setState(() => _currentPage = 1);
  void _previous() => setState(() => _currentPage = 0);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ClosetController>();
    final item = controller.allItems.first;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header nav
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(children: [
                GestureDetector(onTap: Get.back,
                    child: const Icon(Icons.arrow_back_ios_new, size: 16)),
                const SizedBox(width: 8),
                Text('Back to Audit', style: AppTextStyles.bodySmall),
                const Spacer(),
                if (_currentPage == 1)
                  GestureDetector(
                    onTap: _previous,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(8)),
                      child: Text('← Previous', style: AppTextStyles.labelSmall.copyWith(color: Colors.white)),
                    ),
                  ),
                const SizedBox(width: 8),
                if (_currentPage == 0)
                  GestureDetector(
                    onTap: _next,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(8)),
                      child: Text('Next →', style: AppTextStyles.labelSmall.copyWith(color: Colors.white)),
                    ),
                  ),
              ]),
            ),

            // Chips
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: Row(children: [
                _Chip(label: 'Keep Piece', color: AppColors.success),
                const SizedBox(width: 8),
                _Chip(label: '10 Sell Ago', color: Colors.orange),
              ]),
            ),
            const SizedBox(height: 10),

            Expanded(
              child: _currentPage == 0
                  ? _AuditPage1(item: item)
                  : _AuditPage2(item: item),
            ),
          ],
        ),
      ),
    );
  }
}

class _AuditPage1 extends StatelessWidget {
  final ClosetItem item;
  const _AuditPage1({required this.item});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        // Product image
        Container(
          height: 200,
          decoration: BoxDecoration(color: item.color, borderRadius: BorderRadius.circular(14)),
          child: const Center(child: Icon(Icons.dry_cleaning_outlined, size: 70, color: Colors.white30)),
        ),
        const SizedBox(height: 14),

        Text('ARKET', style: AppTextStyles.overline),
        Text(item.name, style: AppTextStyles.headlineMedium),
        Text('Sand', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textTertiary)),
        const SizedBox(height: 16),

        Text('WEARING HABITS — LAST 6 MONTHS', style: AppTextStyles.caption.copyWith(letterSpacing: 0.5, color: AppColors.textTertiary)),
        const SizedBox(height: 10),
        _MiniBarChart(),
        const SizedBox(height: 16),

        Text('COST PER WEAR BREAKDOWN', style: AppTextStyles.caption.copyWith(letterSpacing: 0.5, color: AppColors.textTertiary)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Column(children: [
            _DetailRow('Purchase price', '€${item.costPerWear * 74}'),
            _DetailRow('Today · updated', '€${item.costPerWear.toStringAsFixed(2)}/w'),
            _DetailRow('Previous',        '€${(item.costPerWear + 0.3).toStringAsFixed(2)}'),
            _DetailRow('Item Top',        '€${(item.costPerWear - 0.1).toStringAsFixed(2)}'),
          ]),
        ),
        const SizedBox(height: 16),

        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.success.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.success.withOpacity(0.3)),
          ),
          child: Row(children: [
            const Icon(Icons.check, color: AppColors.success, size: 16),
            const SizedBox(width: 8),
            Text('Recommendation: Keep', style: AppTextStyles.labelMedium.copyWith(color: AppColors.success)),
          ]),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _AuditPage2 extends StatelessWidget {
  final ClosetItem item;
  const _AuditPage2({required this.item});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(color: item.color, borderRadius: BorderRadius.circular(14)),
          child: const Center(child: Icon(Icons.dry_cleaning_outlined, size: 70, color: Colors.white30)),
        ),
        const SizedBox(height: 14),

        Text('ARKET', style: AppTextStyles.overline),
        Text(item.name, style: AppTextStyles.headlineMedium),
        Text('Sand', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textTertiary)),
        const SizedBox(height: 16),

        Text('WEARING HABITS — LAST 6 MONTHS', style: AppTextStyles.caption.copyWith(letterSpacing: 0.5, color: AppColors.textTertiary)),
        const SizedBox(height: 10),
        _MiniBarChart(),
        const SizedBox(height: 16),

        Text('COST PER WEAR BREAKDOWN', style: AppTextStyles.caption.copyWith(letterSpacing: 0.5, color: AppColors.textTertiary)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Column(children: [
            _DetailRow('Purchase price', '€${item.costPerWear * 74}'),
            _DetailRow('Today · updated', '€${item.costPerWear.toStringAsFixed(2)}/w'),
            _DetailRow('Previous',        '€${(item.costPerWear + 0.3).toStringAsFixed(2)}'),
            _DetailRow('Item Top',        '€${(item.costPerWear - 0.1).toStringAsFixed(2)}'),
          ]),
        ),
        const SizedBox(height: 16),

        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.success.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.success.withOpacity(0.3)),
          ),
          child: Row(children: [
            const Icon(Icons.check, color: AppColors.success, size: 16),
            const SizedBox(width: 8),
            Text('Recommendation: Keep', style: AppTextStyles.labelMedium.copyWith(color: AppColors.success)),
          ]),
        ),
        const SizedBox(height: 14),

        // Add to Ghost button (page 2)
        GestureDetector(
          onTap: () => Get.snackbar('Ghost', 'Added to Ghost Pieces', snackPosition: SnackPosition.TOP),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(14)),
            child: Center(child: Text('Add to Ghost', style: AppTextStyles.button)),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _MiniBarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const months = ['Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'Mar'];
    const vals   = [0.3, 0.7, 0.4, 0.9, 0.5, 0.8];
    return Container(
      height: 70,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(6, (i) => Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Expanded(child: FractionallySizedBox(
            heightFactor: vals[i], alignment: Alignment.bottomCenter,
            child: Container(width: 18, decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.6), borderRadius: BorderRadius.circular(3))),
          )),
          const SizedBox(height: 3),
          Text(months[i], style: const TextStyle(fontSize: 8, color: AppColors.textTertiary)),
        ])),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label, value;
  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: AppTextStyles.bodySmall),
      Text(value, style: AppTextStyles.labelMedium),
    ]),
  );
}

class _Chip extends StatelessWidget {
  final String label;
  final Color color;
  const _Chip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(8), border: Border.all(color: color.withOpacity(0.3))),
    child: Text(label, style: AppTextStyles.caption.copyWith(color: color, fontWeight: FontWeight.w600)),
  );
}