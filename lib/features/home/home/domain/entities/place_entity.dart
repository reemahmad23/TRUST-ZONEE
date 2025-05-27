class Feature {
  final int featureId;
  final String featureName;
  final String description;

  Feature({required this.featureId, required this.featureName, required this.description});
}

class Place {
  final String name;
  final int categoryId;
  final double latitude;
  final double longitude;
  final String details;
  final List<Feature> features;

  Place({
    required this.name,
    required this.categoryId,
    required this.latitude,
    required this.longitude,
    required this.details,
    required this.features,
  });
}

class Branch {
  final int id;
  final String address;
  final String website;
  final String phone;
  final String createdAt;
  final Place place;

  Branch({
    required this.id,
    required this.address,
    required this.website,
    required this.phone,
    required this.createdAt,
    required this.place,
  });
}
