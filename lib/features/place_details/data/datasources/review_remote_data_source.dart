import '../models/review_model.dart';
import '../models/review_request_model.dart';

abstract class ReviewRemoteDataSource {
  Future<void> addReview(ReviewRequestModel model);
  Future<List<ReviewModel>> getUserReviews();
  Future<List<ReviewModel>> getReviewsByBranchId(int branchId);


}
