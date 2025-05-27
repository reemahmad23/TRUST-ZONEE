
import '../../../domain/entities/update_profile_entity.dart';

class UpdateProfileModel {
  final String userName;
  final String email;
  final int age;
  final String profilePictureUrl;
  final List<String> disabilityTypes;

  UpdateProfileModel({
    required this.userName,
    required this.email,
    required this.age,
    required this.profilePictureUrl,
    required this.disabilityTypes,
  });

  Map<String, dynamic> toJson() {
    return {
      "userName": userName,
      "email": email,
      "age": age,
      "profilePictureUrl": profilePictureUrl,
      "disabilityTypes": disabilityTypes,
    };
  }

  factory UpdateProfileModel.fromEntity(UpdateProfileEntity entity) {
    return UpdateProfileModel(
      userName: entity.userName,
      email: entity.email,
      age: entity.age,
      profilePictureUrl: entity.profilePictureUrl,
      disabilityTypes: entity.disabilityTypes,
    );
  }
}
