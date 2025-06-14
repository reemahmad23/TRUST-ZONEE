import '../../domain/entities/branch_entity.dart';

class BranchModel extends BranchEntity {
  BranchModel({
    required super.id,
    required super.address,
    required super.website,
    required super.phone,
    required super.placeName,
    required super.openingTime,
    required super.closingTime,
    required super.featureNames,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    final openingHours = json['opiningHours'] as List<dynamic>? ?? [];
    final firstOpeningHour = openingHours.isNotEmpty ? openingHours.first : null;

    final place = json['place'] ?? {};
    final featuresList = place['features'] as List<dynamic>? ?? [];

    return BranchModel(
      id: json['id'],
      address: json['address'] ?? "",
      website: json['website'] ?? "",
      phone: json['phone'] ?? "",
      placeName: place['name'] ?? "",
      openingTime: firstOpeningHour?['openingTime'] ?? "",
      closingTime: firstOpeningHour?['closingTime'] ?? "",
      featureNames: featuresList.map((f) => f['featureName'] as String).toList(),
    );
  }
}
