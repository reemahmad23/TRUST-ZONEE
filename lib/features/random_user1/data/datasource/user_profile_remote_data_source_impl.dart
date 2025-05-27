import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_profile_model.dart';
import 'user_profile_remote_data_source.dart';

class UserProfileRemoteDataSourceImpl implements UserProfileRemoteDataSource {
  final Dio dio;

  UserProfileRemoteDataSourceImpl(this.dio);

  @override
  Future<UserProfileModel> getUserProfile(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null || token.isEmpty) {
      throw Exception("Authentication token not found.");
    }

    try {
      final response = await dio.get(
        'https://trustzone.azurewebsites.net/api/UserProfile/$userId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return UserProfileModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load user profile. Status: ${response.statusCode}');
      }
    } catch (e) {
      print("❌ Error in getUserProfile: $e");
      rethrow;
    }
  }
}
