import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:trust_zone/features/place_details/domain/entities/review_entity.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/review_repository.dart';
import '../../domain/usecaces/create_review_usecase.dart';
import '../datasources/review_remote_data_source.dart';
import '../models/review_request_model.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDataSource remoteDataSource;
  final Dio dio;
  ReviewRepositoryImpl(this.dio, {required this.remoteDataSource});


  @override
  Future<Either<Failure, List<ReviewEntity>>> getUserReviewsByBranchId(int branchId) async {
    try {
      final response = await remoteDataSource.getReviewsByBranchId(branchId);

      final reviews = response.map((model) => model.toEntity()).toList();
      return Right(reviews);

    } catch (e) {
      return Left(ServerFailure(error: e.toString()));
    }
  }




  @override
  Future<Either<Failure, void>> addReview(CreateReviewParams params) async {
    try {
      final model = ReviewRequestModel(
        branchId: params.branchId,
        rating: params.rating,
        comment: params.comment,
      );
      await remoteDataSource.addReview(model);
      return const Right(null);
    } catch (e) {
      print("Error adding review: $e"); // for debugging
      return Left(ServerFailure(error: e.toString()));
    }


  }

}
