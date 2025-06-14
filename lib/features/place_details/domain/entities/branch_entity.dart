class BranchEntity {
  final int id;
  final String address;
  final String website;
  final String phone;
  final String placeName;
  final String openingTime;
  final String closingTime;
  final List<String> featureNames;

  BranchEntity({
    required this.id,
    required this.address,
    required this.website,
    required this.phone,
    required this.placeName,
    required this.openingTime,
    required this.closingTime,
    required this.featureNames,
  });

  factory BranchEntity.fromJson(Map<String, dynamic> json) {
    final openingHours = json['opiningHours'] as List<dynamic>;
    final firstOpeningHour = openingHours.isNotEmpty ? openingHours.first : null;

    final place = json['place'];
    final featuresList = place['features'] as List<dynamic>;

    return BranchEntity(
      id: json['id'],
      address: json['address'],
      website: json['website'],
      phone: json['phone'],
      placeName: place['name'],
      openingTime: firstOpeningHour?['openingTime'] ?? '',
      closingTime: firstOpeningHour?['closingTime'] ?? '',
      featureNames: featuresList.map((f) => f['featureName'] as String).toList(),
    );
  }
}
