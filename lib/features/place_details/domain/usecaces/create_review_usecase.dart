// lib/features/place_details/domain/usecaces/create_review_usecase.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../repositories/review_repository.dart';

class CreateReviewUseCase {
  final ReviewRepository repository;

  CreateReviewUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required int branchId,
    required int rating,
    required String comment,
  }) {
    return repository.addReview(
      CreateReviewParams(
        branchId: branchId,
        rating: rating,
        comment: comment,
      ),
    );
  }
}

class CreateReviewParams {
  final int branchId;
  final int rating;
  final String comment;

  CreateReviewParams({
    required this.branchId,
    required this.rating,
    required this.comment,
  });
}
