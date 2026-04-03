import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../closet_controller.dart';

class AllPiecesScreen extends GetView<ClosetController> {
  const AllPiecesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(children: [
                GestureDetector(onTap: Get.back, child: const Icon(Icons.arrow_back_ios_new, size: 18)),
                const SizedBox(width: 12),
                Text('All Pieces', style: AppTextStyles.headlineSmall),
              ]),
            ),
            const SizedBox(height: 14),
            Obx(() => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: controller.filters.map((f) {
                  final sel = controller.selectedFilter.value == f;
                  return GestureDetector(
                    onTap: () => controller.setFilter(f),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: sel ? AppColors.primary : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: sel ? AppColors.primary : AppColors.border),
                      ),
                      child: Text(f, style: AppTextStyles.labelSmall.copyWith(color: sel ? Colors.white : AppColors.textPrimary)),
                    ),
                  );
                }).toList(),
              ),
            )),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(() => Align(
                alignment: Alignment.centerLeft,
                child: Text('All ${controller.filteredItems.length}', style: AppTextStyles.labelMedium.copyWith(color: AppColors.textTertiary)),
              )),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Obx(() => GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.7,
                ),
                itemCount: controller.filteredItems.length,
                itemBuilder: (_, i) {
                  final item = controller.filteredItems[i];
                  return GestureDetector(
                    onTap: () => controller.onItemTap(item),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(color: item.color, borderRadius: BorderRadius.circular(10)),
                          child: const Center(child: Icon(Icons.checkroom_outlined, color: Colors.white38, size: 26)),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(item.brand, style: AppTextStyles.caption.copyWith(color: AppColors.textTertiary)),
                      Text(item.name, style: AppTextStyles.labelSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                      Text('€${item.costPerWear.toStringAsFixed(2)} CPW', style: AppTextStyles.caption.copyWith(color: AppColors.accent)),
                    ]),
                  );
                },
              )),
            ),
          ],
        ),
      ),
    );
  }
}