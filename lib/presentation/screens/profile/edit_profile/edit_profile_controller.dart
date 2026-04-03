import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  final nameController = TextEditingController(text: 'Sarah');
  final usernameController = TextEditingController(text: '@sarah_myReady');
  final bioController = TextEditingController(text: 'Tell about yourself');
  final locationController = TextEditingController(text: 'New York, NY');
  final emailController = TextEditingController(text: 'abc@example.com');
  final phoneController = TextEditingController(text: '+1 (203) 555-4567');

  final isLoading = false.obs;

  // Style preferences
  final styleOptions = ['Minimal', 'Elegant', 'Maximalist', 'Streetwear', 'Bohemian', 'Sporty', 'Classic'];
  final selectedStyles = <String>['Minimal', 'Elegant'].obs;

  // Brands
  final brandOptions = ['Zara', 'Mango', 'COS', 'H&M', 'Massimo Dutti', 'Arket', 'Groke', '& Other Stories'];
  final selectedBrands = <String>['Zara', 'Mango', 'COS', 'H&M', 'Arket'].obs;

  // Clothing budget
  final clothingBudget = 'Select'.obs;
  final budgetOptions = ['Under €50', '€50–€100', '€100–€200', '€200–€500', 'No limit'];

  // Shopping interests
  final interestOptions = ['Clothing', 'Tops', 'Bottoms', 'Dresses', 'Shoes', 'Accessories', 'Bags', 'Jewelry'];
  final selectedInterests = <String>['Clothing', 'Dresses', 'Shoes'].obs;

  // Color palette
  final colorOptions = ['White', 'Nude', 'Beige', 'Navy', 'Grey', 'Brown', 'Olive'];
  final selectedColors = <String>['White', 'Beige'].obs;

  // Hair color
  final hairOptions = ['Black', 'Brown', 'Blonde', 'Red', 'Other'];
  final selectedHair = 'Black'.obs;

  // Eye color
  final eyeOptions = ['Brown', 'Blue', 'Green', 'Hazel', 'Grey'];
  final selectedEye = 'Brown'.obs;

  // Skin tone
  final skinOptions = ['Fair', 'Light', 'Medium', 'Tan', 'Deep'];
  final selectedSkin = 'Fair'.obs;

  // Height
  final heightController = TextEditingController(text: '175');

  // Clothing size
  final sizeOptions = ['XS', 'S', 'M', 'L', 'XL'];
  final selectedSize = 'M'.obs;

  @override
  void onClose() {
    nameController.dispose();
    usernameController.dispose();
    bioController.dispose();
    locationController.dispose();
    emailController.dispose();
    phoneController.dispose();
    heightController.dispose();
    super.onClose();
  }

  void toggleStyle(String s) {
    selectedStyles.contains(s) ? selectedStyles.remove(s) : selectedStyles.add(s);
  }

  void toggleBrand(String b) {
    selectedBrands.contains(b) ? selectedBrands.remove(b) : selectedBrands.add(b);
  }

  void toggleInterest(String i) {
    selectedInterests.contains(i) ? selectedInterests.remove(i) : selectedInterests.add(i);
  }

  void toggleColor(String c) {
    selectedColors.contains(c) ? selectedColors.remove(c) : selectedColors.add(c);
  }

  Future<void> onSave() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 800));
    isLoading.value = false;
    Get.back();
    Get.snackbar('Saved', 'Profile updated successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF2C1810),
        colorText: const Color(0xFFFFFFFF));
  }
}