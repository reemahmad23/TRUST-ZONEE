import '../../domain/entities/branch_photo.dart';

class BranchPhotoModel extends BranchPhotoEntity {
  BranchPhotoModel({
    required super.id,
    required super.branchId,
    required super.photoUrl,
  });

  factory BranchPhotoModel.fromJson(Map<String, dynamic> json) {
    return BranchPhotoModel(
      id: json['id'],
      branchId: json['branchId'],
      photoUrl: json['photoUrl']??"" ,
    );
  }
}
