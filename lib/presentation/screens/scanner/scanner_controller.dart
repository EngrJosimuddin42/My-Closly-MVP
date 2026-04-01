import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/entities/product_entity.dart';

enum ScannerState { scanning, analyzing, result, manual }

class ScannerController extends GetxController {
  final scannerState = ScannerState.scanning.obs;

  // Detected item
  final detectedItem = Rxn<ClothingItemEntity>();

  // Manual entry
  final itemNameController = TextEditingController();
  final manualQuantity = 5.obs;
  final manualSize = 'M'.obs;
  final manualColor = const Color(0xFF1A1A2E).obs;
  final manualBrand = 'Gap Kids'.obs;

  @override
  void onClose() {
    itemNameController.dispose();
    super.onClose();
  }

  void onScan() {
    scannerState.value = ScannerState.analyzing;
    // Simulate AI analysis
    Future.delayed(const Duration(seconds: 2), () {
      detectedItem.value = ClothingItemEntity(
        id: 'item_001',
        name: 'Classic Sport Shoe',
        brand: 'Gap Kids',
        size: 'M',
        color: '#000000',
        category: 'Shoes',
        addedAt: DateTime.now(),
        isAiDetected: true,
        aiConfidence: 0.96,
      );
      scannerState.value = ScannerState.result;
    });
  }

  void onRetake() {
    detectedItem.value = null;
    scannerState.value = ScannerState.scanning;
  }

  void onSaveItem() {
    // Save to closet
    Get.back(result: detectedItem.value);
    Get.snackbar(
      'Saved!',
      '${detectedItem.value?.name} added to your closet.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF2C1810),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  void onScanAnother() {
    detectedItem.value = null;
    scannerState.value = ScannerState.scanning;
  }

  void onManual() {
    scannerState.value = ScannerState.manual;
  }

  void onGallery() {
    // TODO: image_picker gallery
  }

  void incrementQuantity() => manualQuantity.value++;
  void decrementQuantity() {
    if (manualQuantity.value > 1) manualQuantity.value--;
  }

  void onSaveManual() {
    if (itemNameController.text.isEmpty) {
      Get.snackbar('Required', 'Please enter an item name',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.orange.shade700,
          colorText: Colors.white);
      return;
    }
    Get.back();
    Get.snackbar(
      'Saved!',
      '${itemNameController.text} added to your closet.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF2C1810),
      colorText: Colors.white,
    );
  }
}