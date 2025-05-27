import 'package:trust_zone/features/place_details/domain/entities/user_entity.dart';

class ReviewEntity {
  final int id;
  final int branchId;
  final int rating;
  final String comment;
  final String? createdAt;
  final UserEntity user;

  ReviewEntity({
    required this.id,
    required this.branchId,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.user,
  });
}


