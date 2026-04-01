import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/entities/ user_entity.dart';
import '../../../routes/app_routes.dart';

enum OnboardingStep {
  intro,
  bodyProfile,
  fitMeasurements,
  appearance,
  colorPreferences,
  style,
  category,
  brands,
  budget,
  lifestyle,
}

class OnboardingController extends GetxController {
  final pageController = PageController();

  final currentStep = 0.obs;
  final totalSteps = OnboardingStep.values.length;

  // ── Body Profile ──────────────────────────────────────────────
  final weightController = TextEditingController(text: '70');
  final heightController = TextEditingController(text: '175');
  final chestController = TextEditingController(text: '100');
  final waistController = TextEditingController(text: '82');
  final hipController = TextEditingController(text: '95');
  final selectedBodySize = 'XL'.obs;
  final selectedShoeSize = 41.obs;
  final selectedBodyType = 'Relaxed'.obs;

  final bodySizes = ['S', 'M', 'L', 'XL', 'XXL', 'XXXL'];
  final shoeSizes = [38, 39, 40, 41, 42, 43];
  final bodyTypes = ['Relaxed', 'Regular', 'Slim', 'Mix'];

  // ── Fit & Measurements ────────────────────────────────────────
  final chestSize = 88.obs;
  final waistSize = 88.obs;
  final hipSize = 88.obs;
  final tipSize = 44.obs;

  // ── Appearance ────────────────────────────────────────────────
  final selectedHairColor = 0.obs;
  final selectedEyeColor = 'Brown'.obs;
  final selectedSkinTone = 2.obs;

  final hairColors = ['Black', 'Brown', 'Blonde', 'Red', 'Grey'];
  final eyeColors = ['Brown', 'Blue', 'Green', 'Grey'];
  final skinTones = [
    Color(0xFFF8D5B0), Color(0xFFF0C090), Color(0xFFD4956A),
    Color(0xFFB07040), Color(0xFF8B5530), Color(0xFF5A3010),
  ];

  // ── Color Preferences ─────────────────────────────────────────
  final selectedColors = <String>[].obs;
  final colorGroups = {
    'NEUTRALS & BASICS': [
      {'name': 'White & Cream', 'color': Color(0xFFF5F0E8)},
      {'name': 'Beige & Sand', 'color': Color(0xFFD4B896)},
      {'name': 'Black', 'color': Color(0xFF1C1C1C)},
    ],
    'EARTH & WARM': [
      {'name': 'Camel & Tan', 'color': Color(0xFFC49A6C)},
      {'name': 'Rust', 'color': Color(0xFFB05030)},
      {'name': 'Burgundy', 'color': Color(0xFF7B1828)},
    ],
    'COOL & STATEMENT': [
      {'name': 'Yellow & Mustard', 'color': Color(0xFFD4A820)},
      {'name': 'Navy & Blue', 'color': Color(0xFF1A3A5C)},
      {'name': 'Olive & Green', 'color': Color(0xFF4A5830)},
    ],
  };

  // ── Style ─────────────────────────────────────────────────────
  final selectedStyles = <String>[].obs;
  final styleOptions = [
    'Minimal', 'Streetwear', 'Elegant', 'Casual',
    'Sporty', 'Classic', 'Trendy', 'Vintage',
  ];

  // ── Category ──────────────────────────────────────────────────
  final selectedCategories = <String>[].obs;
  final categories = ['Tops', 'Dresses', 'Jeans', 'Pants', 'Shoes', 'Jackets', 'Bags', 'Accessories'];

  // ── Brands ────────────────────────────────────────────────────
  final selectedBrands = <String>[].obs;
  final brandSearchController = TextEditingController();
  final brandOptions = [
    'Zara', 'Mango', 'H&M', 'COS', 'Nike', 'Adidas',
    'Arket', 'Uniqlo', 'Massimo Dutti', '& Other Stories',
    'Everlane', 'Reformation', "Levi's", 'Gap',
    'Banana Republic', 'J.Crew',
  ];

  // ── Budget ────────────────────────────────────────────────────
  final tShirtBudget = 30.0.obs;
  final trouserBudget = 60.0.obs;
  final shoesBudget = 90.0.obs;
  final bagsBudget = 125.0.obs;
  final knitwearBudget = 50.0.obs;

  // ── Lifestyle ─────────────────────────────────────────────────
  final selectedLifestyle = ''.obs;
  final lifestyles = ['Office / Work', 'University', 'Remote / Home', 'Creative Work', 'Outdoor / Active', 'Fitness / Sports'];

  // ─────────────────────────────────────────────────────────────

  @override
  void onClose() {
    pageController.dispose();
    weightController.dispose();
    heightController.dispose();
    chestController.dispose();
    waistController.dispose();
    hipController.dispose();
    brandSearchController.dispose();
    super.onClose();
  }

  double get progress => (currentStep.value + 1) / totalSteps;

  void onNext() {
    if (currentStep.value < totalSteps - 1) {
      currentStep.value++;
      pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      _onComplete();
    }
  }

  void onBack() {
    if (currentStep.value > 0) {
      currentStep.value--;
      pageController.previousPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      Get.back();
    }
  }

  void onSkip() => onNext();

  void toggleColor(String name) {
    if (selectedColors.contains(name)) {
      selectedColors.remove(name);
    } else {
      selectedColors.add(name);
    }
  }

  void toggleStyle(String style) {
    if (selectedStyles.contains(style)) {
      selectedStyles.remove(style);
    } else {
      selectedStyles.add(style);
    }
  }

  void toggleCategory(String cat) {
    if (selectedCategories.contains(cat)) {
      selectedCategories.remove(cat);
    } else {
      selectedCategories.add(cat);
    }
  }

  void toggleBrand(String brand) {
    if (selectedBrands.contains(brand)) {
      selectedBrands.remove(brand);
    } else {
      selectedBrands.add(brand);
    }
  }

  void selectBodySize(String s) => selectedBodySize.value = s;
  void selectShoeSize(int s) => selectedShoeSize.value = s;
  void selectBodyType(String t) => selectedBodyType.value = t;
  void selectEyeColor(String c) => selectedEyeColor.value = c;
  void selectHairColor(int i) => selectedHairColor.value = i;
  void selectSkinTone(int i) => selectedSkinTone.value = i;
  void selectLifestyle(String l) => selectedLifestyle.value = l;

  UserPreferences buildPreferences() {
    return UserPreferences(
      categories: selectedCategories.toList(),
      brands: selectedBrands.toList(),
      styles: selectedStyles.toList(),
      colors: selectedColors.toList(),
      eyeColor: selectedEyeColor.value,
      lifestyles: [selectedLifestyle.value],
    );
  }

  void _onComplete() {
    Get.toNamed(AppRoutes.wardrobe);
  }
}