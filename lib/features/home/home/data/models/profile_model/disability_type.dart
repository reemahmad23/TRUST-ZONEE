// disability_type.dart

class DisabilityTypeModel {
  final int id;
  final String name;

  DisabilityTypeModel({required this.id, required this.name});

  factory DisabilityTypeModel.fromJson(Map<String, dynamic> json) {
    return DisabilityTypeModel(
      id: json['id'],
      name: json['name']?.toString() ?? '',
    );
  }
}
