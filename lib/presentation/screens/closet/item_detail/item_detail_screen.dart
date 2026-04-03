import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../closet_controller.dart';

class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final item = Get.arguments as ClosetItem;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: GestureDetector(
                onTap: Get.back,
                child: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.textPrimary),
              ),
              title: Text('Back to Items', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary)),
              backgroundColor: Colors.white,
              elevation: 0,
              actions: [
                IconButton(icon: const Icon(Icons.upload_outlined, color: AppColors.textSecondary), onPressed: () {}),
                IconButton(icon: const Icon(Icons.edit_outlined, color: AppColors.textSecondary), onPressed: () {}),
              ],
              expandedHeight: 260,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: item.color,
                  child: const Center(child: Icon(Icons.dry_cleaning_outlined, size: 100, color: Colors.white30)),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // AI tag
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.aiMatchBadge.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        const Icon(Icons.auto_awesome, size: 12, color: AppColors.aiMatchBadge),
                        const SizedBox(width: 4),
                        Text('AI Match · ${item.styleMatch}', style: AppTextStyles.caption.copyWith(color: AppColors.aiMatchBadge, fontWeight: FontWeight.w600)),
                      ]),
                    ),
                    const SizedBox(height: 10),
                    Text(item.name, style: AppTextStyles.headlineLarge),
                    Text('${item.brand} · Size ${item.size} · Added 4 months ago · Beige', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textTertiary)),
                    const SizedBox(height: 20),

                    // Stats row
                    Row(children: [
                      _ItemStat(label: 'Times Worn',    value: '${item.timesWorn}'),
                      _ItemStat(label: 'Cost / Wear',   value: '€${item.costPerWear.toStringAsFixed(2)}'),
                      _ItemStat(label: 'Click-to-Wear', value: '80%'),
                      _ItemStat(label: 'Score',         value: '9.6'),
                    ]),
                    const SizedBox(height: 20),

                    // Wearing habits chart
                    _SectionTitle('WEARING HABITS — LAST 6 MONTHS'),
                    const SizedBox(height: 10),
                    _WearingHabitsChart(),
                    const SizedBox(height: 20),

                    // Cost per wear breakdown
                    _SectionTitle('COST PER WEAR BREAKDOWN'),
                    const SizedBox(height: 10),
                    _CostBreakdown(item: item),
                    const SizedBox(height: 20),

                    // Outfit match
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                      child: Row(children: [
                        const Icon(Icons.check_circle_outline, color: AppColors.success, size: 20),
                        const SizedBox(width: 10),
                        Expanded(child: Text('Purchase price €89. Worn how: 42× Lifted cost from €89 to €1.20/wear. Every wear now saves you money.', style: AppTextStyles.bodySmall)),
                      ]),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                      child: Row(children: [
                        const Icon(Icons.warning_amber_outlined, color: AppColors.warning, size: 20),
                        const SizedBox(width: 10),
                        Expanded(child: Text('You no longer matches your DNA. Your improvement into Minimal will WFH Minimal — the key approach to the other side of the season.', style: AppTextStyles.bodySmall)),
                      ]),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                      child: Row(children: [
                        const Icon(Icons.eco_outlined, color: AppColors.success, size: 20),
                        const SizedBox(width: 10),
                        Expanded(child: Text('Environmental gain: Textiles can default when shown in a closet, saving 4.1kg CO₂ vs new production.', style: AppTextStyles.bodySmall)),
                      ]),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemStat extends StatelessWidget {
  final String label, value;
  const _ItemStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(value, style: AppTextStyles.headlineSmall.copyWith(fontSize: 16)),
          Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.textTertiary, fontSize: 9)),
        ]),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) =>
      Text(text, style: AppTextStyles.caption.copyWith(color: AppColors.textTertiary, letterSpacing: 0.6, fontWeight: FontWeight.w700));
}

class _WearingHabitsChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const months = ['Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'Mar'];
    const values = [0.4, 0.6, 0.3, 0.8, 0.5, 0.9];
    return Container(
      height: 80,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(months.length, (i) => Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: FractionallySizedBox(
                heightFactor: values[i],
                alignment: Alignment.bottomCenter,
                child: Container(width: 20, decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.6), borderRadius: BorderRadius.circular(4))),
              ),
            ),
            const SizedBox(height: 4),
            Text(months[i], style: AppTextStyles.caption.copyWith(fontSize: 9)),
          ],
        )),
      ),
    );
  }
}

class _CostBreakdown extends StatelessWidget {
  final ClosetItem item;
  const _CostBreakdown({required this.item});

  @override
  Widget build(BuildContext context) {
    final rows = [
      {'label': 'Purchase price', 'value': '€89'},
      {'label': 'Today · updated', 'value': '€${item.costPerWear.toStringAsFixed(2)}/w'},
      {'label': 'Previous',        'value': '€${(item.costPerWear + 0.5).toStringAsFixed(2)}'},
      {'label': 'Item Top',        'value': '€${(item.costPerWear - 0.3).toStringAsFixed(2)}'},
    ];
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: rows.map((r) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(r['label']!, style: AppTextStyles.bodySmall),
            Text(r['value']!, style: AppTextStyles.labelMedium),
          ]),
        )).toList(),
      ),
    );
  }
}