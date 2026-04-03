import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../closet_controller.dart';

class GhostPiecesScreen extends GetView<ClosetController> {
  const GhostPiecesScreen({super.key});

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
                Text('Back to Ghost Pieces', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary)),
              ]),
            ),
            const SizedBox(height: 14),

            // Filter row (same as all pieces)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: ['All 47', 'Tops', 'Bottoms', 'Shoes'].map((f) {
                  final isFirst = f == 'All 47';
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isFirst ? AppColors.primary : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: isFirst ? AppColors.primary : AppColors.border),
                    ),
                    child: Text(f, style: AppTextStyles.labelSmall.copyWith(color: isFirst ? Colors.white : AppColors.textPrimary)),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  // Sub-tabs: At Risk, Top 10 Worn, Care Items
                  Row(children: ['At Risk', 'Top 10 Worn', 'Care Items'].map((t) =>
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Text(t, style: AppTextStyles.bodySmall.copyWith(
                          color: t == 'At Risk' ? AppColors.primary : AppColors.textTertiary,
                          fontWeight: t == 'At Risk' ? FontWeight.w600 : FontWeight.w400,
                          decoration: t == 'At Risk' ? TextDecoration.underline : null,
                        )),
                      ),
                  ).toList()),
                  const SizedBox(height: 14),

                  // Ghost items grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.7,
                    ),
                    itemCount: controller.allItems.length,
                    itemBuilder: (_, i) {
                      final item = controller.allItems[i];
                      return GestureDetector(
                        onTap: () => controller.onItemTap(item),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Expanded(
                            child: Stack(children: [
                              Container(
                                decoration: BoxDecoration(color: item.color, borderRadius: BorderRadius.circular(10)),
                                child: const Center(child: Icon(Icons.checkroom_outlined, color: Colors.white38, size: 26)),
                              ),
                              // "127 DAYS UNWORN" stamp on ghost items
                              if (item.isGhost)
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Transform.rotate(
                                        angle: -0.3,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.white60),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Text('${item.daysUnworn} DAYS\nUNWORN',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(color: Colors.white, fontSize: 7, fontWeight: FontWeight.w700, letterSpacing: 0.5)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ]),
                          ),
                          const SizedBox(height: 4),
                          Text(item.brand, style: AppTextStyles.caption.copyWith(color: AppColors.textTertiary)),
                          Text(item.name, style: AppTextStyles.labelSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                          Text('€${item.costPerWear.toStringAsFixed(2)} CPW', style: AppTextStyles.caption.copyWith(color: AppColors.accent)),
                        ]),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}