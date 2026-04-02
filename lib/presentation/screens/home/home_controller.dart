import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../routes/app_routes.dart';

class HomeController extends GetxController {
  final selectedFeedTab = 0.obs;
  final selectedSize = 'M'.obs;

  final forYouProducts = <ProductEntity>[
    ProductEntity(id: '1', name: 'Cashmere Overcoat', brand: 'The Row', price: 1890, matchPercentage: 97, category: 'Jackets'),
    ProductEntity(id: '2', name: 'Linen Blazer',      brand: 'Arket',   price: 89,   matchPercentage: 92, category: 'Tops'),
    ProductEntity(id: '3', name: 'Linen Blazer',      brand: 'Arket',   price: 89,   matchPercentage: 88, category: 'Tops'),
  ];

  final followsProducts = <ProductEntity>[
    ProductEntity(id: '4', name: 'Anagram Hoodie', brand: '', price: 850),
    ProductEntity(id: '5', name: 'Silk Wrap Dress', brand: '', price: 24),
  ];

  void setFeedTab(int tab) => selectedFeedTab.value = tab;
  void selectSize(String size) => selectedSize.value = size;

  void onShopNow() => Get.snackbar('Shop Now', 'Opening product page...',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF2C1810),
      colorText: Colors.white);

  void onScannerTap() => Get.toNamed(AppRoutes.scanner);
  void onClosetTap()  => Get.toNamed(AppRoutes.wardrobe);

  final sizes = ['XS', 'S', 'M', 'L', 'XL'];
  final weatherTemp = 14.obs;
  final weatherDesc = 'Partly cloudy'.obs;
  final aiOutfitDesc = 'Cool & overcast — perfect for your Linen Blazer. Layered with your ribbed tee and loafers.'.obs;
}