import '../../domain/entities/review_entity.dart';
import '../../domain/entities/user_entity.dart';

class UserModel {
  final String id;
  final String userName;
  final String profilePictureUrl;

  UserModel({
    required this.id,
    required this.userName,
    required this.profilePictureUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']??"",
      userName: json['userName']??"",
      profilePictureUrl: json['profilePictureUrl']??"",
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      userName: userName,
      profilePictureUrl: profilePictureUrl,
    );
  }
}
