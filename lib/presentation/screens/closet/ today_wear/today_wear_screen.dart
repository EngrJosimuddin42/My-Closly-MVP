import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../closet_controller.dart';

class TodayWearScreen extends GetView<ClosetController> {
  const TodayWearScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // AppBar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(onTap: Get.back,
                      child: const Icon(Icons.arrow_back_ios_new, size: 18)),
                  Text("Today's Outfit", style: AppTextStyles.headlineSmall),
                  IconButton(icon: const Icon(Icons.share_outlined, size: 20), onPressed: () {}),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Friday, 03 Apr 2026', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textTertiary)),
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  // "Your Closet" section with horizontal scroll
                  Text("Your Closet", style: AppTextStyles.headlineSmall),
                  const SizedBox(height: 4),
                  Text('Select items to log today\'s outfit', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textTertiary)),
                  const SizedBox(height: 12),

                  // Filter tabs
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: ['All', 'Tops', 'Bottoms', 'Shoes'].map((f) =>
                          Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                            decoration: BoxDecoration(
                              color: f == 'All' ? AppColors.primary : Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(color: f == 'All' ? AppColors.primary : AppColors.border),
                            ),
                            child: Text(f, style: AppTextStyles.labelSmall.copyWith(color: f == 'All' ? Colors.white : AppColors.textPrimary)),
                          ),
                      ).toList(),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Closet grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.75,
                    ),
                    itemCount: controller.allItems.length,
                    itemBuilder: (_, i) {
                      final item = controller.allItems[i];
                      return _TodayWearItem(item: item);
                    },
                  ),
                  const SizedBox(height: 20),

                  // Log outfit button
                  GestureDetector(
                    onTap: () => Get.snackbar('Logged! +50 pts', 'Outfit logged for today', snackPosition: SnackPosition.TOP, backgroundColor: AppColors.primary, colorText: Colors.white),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(14)),
                      child: Center(child: Text('Log Outfit', style: AppTextStyles.button)),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TodayWearItem extends StatefulWidget {
  final ClosetItem item;
  const _TodayWearItem({required this.item});

  @override
  State<_TodayWearItem> createState() => _TodayWearItemState();
}

class _TodayWearItemState extends State<_TodayWearItem> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _selected = !_selected),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                color: widget.item.color,
                borderRadius: BorderRadius.circular(10),
                border: _selected ? Border.all(color: AppColors.primary, width: 2.5) : null,
              ),
              child: const Center(child: Icon(Icons.checkroom_outlined, color: Colors.white38, size: 26)),
            ),
            if (_selected)
              Positioned(
                top: 6, right: 6,
                child: Container(
                  width: 20, height: 20,
                  decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                  child: const Icon(Icons.check, color: Colors.white, size: 13),
                ),
              ),
          ]),
        ),
        const SizedBox(height: 4),
        Text(widget.item.brand, style: AppTextStyles.caption.copyWith(color: AppColors.textTertiary)),
        Text(widget.item.name, style: AppTextStyles.labelSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
      ]),
    );
  }
}