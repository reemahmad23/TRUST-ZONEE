import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../utils/token_helper.dart';
import '../models/review_model.dart';
import '../models/review_request_model.dart';
import 'review_remote_data_source.dart';

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
final Dio dio;

ReviewRemoteDataSourceImpl(this.dio);



@override
Future<List<ReviewModel>> getReviewsByBranchId(int branchId) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  if (token == null || token.isEmpty) {
    throw Exception("Authentication token not found.");
  }

  try {
    final response = await dio.get(
      'https://trustzone.azurewebsites.net/api/reviews/branch/$branchId',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    final List jsonList = response.data;
    return jsonList.map((json) => ReviewModel.fromJson(json)).toList();
  } catch (e) {
    print("❌ Error in getReviewsByBranchId: $e");
    throw Exception("Failed to load reviews.");
  }
}

@override
Future<List<ReviewModel>> getUserReviews() async {
  final token = await TokenHelper.getToken();
  if (token == null || token.isEmpty) {
    throw Exception("Authentication token not found.");
  }

  try {
    final response = await dio.get(
      'https://trustzone.azurewebsites.net/api/reviews/branch',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    final List jsonList = response.data;
    return jsonList.map((json) => ReviewModel.fromJson(json)).toList();
  } catch (e) {

    throw Exception("Failed to load user reviews.");
  }
}



@override
Future<void> addReview(ReviewRequestModel model) async {
  final token = await TokenHelper.getToken();
  if (token == null || token.isEmpty) {
    throw Exception("Authentication token not found.");
  }

  try {
    final response = await dio.post(
      'https://trustzone.azurewebsites.net/api/Reviews/create',
      data: {
        "branchId": model.branchId,
        "rating": model.rating,
        "comment": model.comment,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to create review. Status: ${response.statusCode}');
    }

    print(" Review successfully submitted.");
  } catch (e) {
    print(" Error sending review: $e");
    rethrow;
  }
}


}
