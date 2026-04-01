class ProductEntity {
  final String id;
  final String name;
  final String brand;
  final double price;
  final String currency;
  final String? imageUrl;
  final List<String> images;
  final List<String> availableSizes;
  final String? color;
  final String? category;
  final double? matchPercentage;
  final bool isFavorited;
  final String? matchDescription;
  final List<String>? matchesInCloset;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    this.currency = '€',
    this.imageUrl,
    this.images = const [],
    this.availableSizes = const [],
    this.color,
    this.category,
    this.matchPercentage,
    this.isFavorited = false,
    this.matchDescription,
    this.matchesInCloset,
  });

  String get formattedPrice => '${currency}${price.toStringAsFixed(0)}';
}

class ClothingItemEntity {
  final String id;
  final String name;
  final String? brand;
  final String? size;
  final String? color;
  final String? category;
  final String? imageUrl;
  final int quantity;
  final DateTime addedAt;
  final bool isAiDetected;
  final double? aiConfidence;

  const ClothingItemEntity({
    required this.id,
    required this.name,
    this.brand,
    this.size,
    this.color,
    this.category,
    this.imageUrl,
    this.quantity = 1,
    required this.addedAt,
    this.isAiDetected = false,
    this.aiConfidence,
  });
}

class OutfitSuggestionEntity {
  final String id;
  final List<ProductEntity> items;
  final String? occasion;
  final String? description;
  final String? weatherContext;

  const OutfitSuggestionEntity({
    required this.id,
    required this.items,
    this.occasion,
    this.description,
    this.weatherContext,
  });
}