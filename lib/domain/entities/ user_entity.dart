class UserEntity {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final String? location;
  final String? styleProfile;
  final UserMeasurements? measurements;
  final UserPreferences? preferences;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    this.location,
    this.styleProfile,
    this.measurements,
    this.preferences,
  });
}

class UserMeasurements {
  final double? weight;
  final double? height;
  final double? chest;
  final double? waist;
  final double? hip;
  final String? bodySize; // S, M, L, XL, XXL
  final int? shoeSize;
  final String? bodyType; // Relaxed, Regular, Slim, Mix

  const UserMeasurements({
    this.weight,
    this.height,
    this.chest,
    this.waist,
    this.hip,
    this.bodySize,
    this.shoeSize,
    this.bodyType,
  });
}

class UserPreferences {
  final List<String> categories;
  final List<String> brands;
  final List<String> styles;
  final List<String> colors;
  final String? hairColor;
  final String? eyeColor;
  final String? skinTone;
  final Map<String, double>? budgets;
  final List<String> lifestyles;

  const UserPreferences({
    this.categories = const [],
    this.brands = const [],
    this.styles = const [],
    this.colors = const [],
    this.hairColor,
    this.eyeColor,
    this.skinTone,
    this.budgets,
    this.lifestyles = const [],
  });
}