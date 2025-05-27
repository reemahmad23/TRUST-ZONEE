class FeatureModel {
  final int featureId;
  final String featureName;
  final String description;

  FeatureModel({
    required this.featureId,
    required this.featureName,
    required this.description,
  });

  factory FeatureModel.fromJson(Map<String, dynamic> json) {
    return FeatureModel(
      featureId: json['featureId'] ?? 0,
      featureName: json['featureName'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );
  }
}

class PlaceModel {
  final String name;
  final int categoryId;
  final double latitude;
  final double longitude;
  final String details;
  final List<FeatureModel> features;

  PlaceModel({
    required this.name,
    required this.categoryId,
    required this.latitude,
    required this.longitude,
    required this.details,
    required this.features,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      name: json['name'] as String? ?? '',
      categoryId: json['categoryId'] ?? 0,
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      details: json['details'] as String? ?? '',
      features: (json['features'] as List?)
          ?.map((feature) => FeatureModel.fromJson(feature))
          .toList() ??
          [],
    );
  }
}

class BranchModel {
  final int id;
  final String address;
  final String website;
  final String phone;
  final String createdAt;
  final PlaceModel place;

  BranchModel({
    required this.id,
    required this.address,
    required this.website,
    required this.phone,
    required this.createdAt,
    required this.place,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    PlaceModel place;

    if (json.containsKey('place') && json['place'] != null) {
      place = PlaceModel.fromJson(json['place']);
    } else {
      place = PlaceModel(
        name: json['placeName'] as String? ?? '',
        categoryId: 0,
        latitude: 0.0,
        longitude: 0.0,
        details: '',
        features: [],
      );
    }

    return BranchModel(
      id: json['id'] ?? 0,
      address: json['address'] as String? ?? '',
      website: json['website'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      place: place,
    );
  }

}