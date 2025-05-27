import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../features/home/home/data/models/favorite_place_model.dart';

abstract class ApiService {
  Future<void> addFavorite(int branchId);
  Future<void> deleteFavorite(int branchId);
  Future<List<FavoriteModel>> getFavorites();
}

class ApiServiceImpl implements ApiService {
  final Dio dio;

  ApiServiceImpl(this.dio);

  // طريقة للحصول على الهيدرز مع التوكن ديناميكياً
  Future<Options> get _headers async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    return Options(
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
  }

  @override
  Future<void> addFavorite(int branchId) async {
    print("Sending addFavorite request for branchId: $branchId");
    final options = await _headers;
    final response = await dio.post(
      'https://trustzone.azurewebsites.net/api/FavoritePlace',
      data: {"branchId": branchId},
      options: options,
    );
    print("Response status: ${response.statusCode}");
    print("Response data: ${response.data}");
  }

  @override
  Future<void> deleteFavorite(int branchId) async {
    final options = await _headers;
    final response = await dio.delete(
      'https://trustzone.azurewebsites.net/api/FavoritePlace/$branchId',
      options: options,
    );
    print("Deleted branchId $branchId, response: ${response.statusCode}");
  }

  @override
  Future<List<FavoriteModel>> getFavorites() async {
    final options = await _headers;
    final response = await dio.get(
      'https://trustzone.azurewebsites.net/api/FavoritePlace',
      options: options,
    );
    print("Get favorites status: ${response.statusCode}");
    print("Favorites data: ${response.data}");
    final data = response.data as List;
    return data.map((e) => FavoriteModel.fromJson(e)).toList();
  }
}