import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/review_entity.dart';
import '../usecaces/create_review_usecase.dart';

abstract class ReviewRepository {
  Future<Either<Failure, List<ReviewEntity>>> getUserReviewsByBranchId(int branchId );
  Future<Either<Failure, void>> addReview(CreateReviewParams params);


}
