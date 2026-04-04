import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../domain/entities/product_entity.dart';
import '../../widgets/product_card.dart';

class ExploreStyleScreen extends StatelessWidget {
  const ExploreStyleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => Get.back(),
        ),
        title: Text('Expand your style', style: AppTextStyles.headlineSmall),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          mainAxisSpacing: 16,
          crossAxisSpacing: 12,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return const SmallProductCard(
            product: ProductEntity(
                id: '1',
                name: 'Linen Blazer',
                brand: 'ARKET',
                price: 89
            ),
          );
        },
      ),
    );
  }
}