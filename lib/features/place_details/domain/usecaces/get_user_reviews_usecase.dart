import 'package:dartz/dartz.dart';
import 'package:trust_zone/core/error/failure.dart';
import 'package:trust_zone/features/place_details/domain/entities/review_entity.dart';
import 'package:trust_zone/features/place_details/domain/repositories/review_repository.dart';

class GetUserReviewsUseCase {
  final ReviewRepository repository;

  GetUserReviewsUseCase(this.repository);

  Future<Either<Failure, List<ReviewEntity>>> call(int branchId) async {
    return await repository.getUserReviewsByBranchId(branchId);
  }
}
