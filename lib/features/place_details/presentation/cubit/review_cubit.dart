
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trust_zone/features/place_details/domain/entities/review_entity.dart';
import 'package:trust_zone/features/place_details/domain/usecaces/create_review_usecase.dart';
import 'package:trust_zone/utils/shared_user_data.dart';
import '../../domain/usecaces/get_user_reviews_usecase.dart';
import 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final CreateReviewUseCase addReviewUseCase;
  final GetUserReviewsUseCase getUserReviewsUseCase;

  List<ReviewEntity> reviews = [];

  ReviewCubit({
    required this.addReviewUseCase,
    required this.getUserReviewsUseCase,
  }) : super(ReviewInitial());
  static ReviewCubit get(context) => BlocProvider.of(context);
  String formatToday() {
    final now = DateTime.now();
    return "${now.day} ${_monthAbbreviation(now.month)}";
  }

  String _monthAbbreviation(int month) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month];
  }

  Future<void> getUserReviewsByBranchId(int branchId) async {

    emit(ReviewLoading());
    reviews =[];
    try {
      final reviewsResult = await getUserReviewsUseCase(branchId);

      reviewsResult.fold(
        (failure) {
          emit(ReviewError("Failed to load reviews...."));
        },
        (reviewsL) {
          final reviewList = reviewsL.map((e) {
            return ReviewEntity(
              id: e.id,
              branchId: e.branchId,
              rating: e.rating,
              comment: e.comment,
              createdAt: e.createdAt,
              user: e.user,
            );
          }).toList();
          reviews =reviewList;
          emit(ReviewLoaded(reviewList));
        },
      );
    } catch (e) {
      emit(ReviewError("Failed to load reviews"));
    }
  }


  Future<void> addReview({
    required int branchId,
    required int rating,
    required String comment,
  }) async
  {
    emit(ReviewLoading());
    final result = await addReviewUseCase(
      branchId: branchId,
      rating: rating,
      comment: comment,
    );
    result.fold(
      (failure) {
        emit(ReviewError("Failed to submit review"));
      },
      (_) async{

        await getUserReviewsByBranchId(branchId );
        emit(ReviewSuccess("Review submitted successfully."));

      },
    );
  }
}
