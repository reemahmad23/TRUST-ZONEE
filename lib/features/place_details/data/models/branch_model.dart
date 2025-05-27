
import '../../domain/entities/branch_entity.dart';

class BranchModel extends BranchEntity {
  BranchModel({
    required super.id,
    required super.address,
    required super.website,
    required super.phone,
    required super.placeName,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    print(json);
    print("-----------------------------------------");
    return BranchModel(
      id: json['id'],
      address: json['address']?? "",
      website: json['website']??"",
      phone: json['phone']??"",
      placeName: json['placeName']??"",
    );
  }
}
