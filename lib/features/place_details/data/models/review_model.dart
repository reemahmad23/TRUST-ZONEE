import 'package:trust_zone/features/place_details/data/models/user_model.dart';
import '../../domain/entities/review_entity.dart';


class ReviewModel {
  final int id;
  final int branchId;
  final int rating;
  final String comment;
  final String? createdAt;
  final UserModel user;

  ReviewModel({
    required this.id,
    required this.branchId,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.user,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      branchId: json['branchId'],
      rating: json['rating'],
      comment: json['comment']??"",
      createdAt: json['createdAt']??"",
      user: UserModel.fromJson(json['user']),
    );
  }

  ReviewEntity toEntity() {
    return ReviewEntity(
      id: id,
      branchId: branchId,
      rating: rating,
      comment: comment,
      createdAt: createdAt,
      user: user.toEntity(),
    );
  }
}
