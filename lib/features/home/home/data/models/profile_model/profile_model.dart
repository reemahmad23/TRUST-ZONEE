



import 'package:trust_zone/features/home/home/data/models/profile_model/disability_type.dart';

import '../../../domain/entities/profile_entity.dart';

class UserProfileModel {
  final String id;
  final String userName;
  final String email;
  final String profilePictureUrl;
  final String coverPictureUrl;
  final List<DisabilityTypeModel> disabilityTypes;
  final int age;

  UserProfileModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.profilePictureUrl,
    required this.coverPictureUrl,
    required this.disabilityTypes,
    required this.age,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'].toString(),
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      profilePictureUrl: json['profilePictureUrl'] ?? '',
      coverPictureUrl: json['coverPictureUrl'] ?? '',
      disabilityTypes: (json['disabilityTypes'] as List)
          .map((e) => DisabilityTypeModel.fromJson(e))
          .toList(),
      age: json['age'] ?? 0,
    );
  }

  UserProfile toEntity() {
    return UserProfile(
      userName: userName,
      email: email,
      age: age,
      profilePictureUrl: profilePictureUrl,
      disabilityTypes: disabilityTypes.map((e) => e.name).toList(),
    );
  }
}
