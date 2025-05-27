import 'package:dio/dio.dart';

abstract class FavoriteRemoteDataSource {
  Future<void> addToFavorites(int branchId);
  Future<void> removeFromFavorites(int branchId);
  Future<List<Map<String, dynamic>>> getFavorites();
}


class FavoriteRemoteDataSourceImpl implements FavoriteRemoteDataSource {
  final Dio dio;

  FavoriteRemoteDataSourceImpl(this.dio);

  static const String baseUrl = 'https://trustzone.azurewebsites.net/api/FavoritePlace';

  @override
  Future<void> addToFavorites(int branchId) async {
    try {
      final response = await dio.post(
        baseUrl,
        data: {'branchId': branchId},
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to add to favorites');
      }
    } catch (e) {
      throw Exception('Error adding to favorites: $e');
    }
  }

  @override
  Future<void> removeFromFavorites(int branchId) async {
    try {
      final response = await dio.delete('$baseUrl/$branchId');

      if (response.statusCode != 200) {
        throw Exception('Failed to remove from favorites');
      }
    } catch (e) {
      throw Exception('Error removing from favorites: $e');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getFavorites() async {
    try {
      final response = await dio.get(baseUrl);

      if (response.statusCode != 200) {
        throw Exception('Failed to load favorites');
      }

      final List<dynamic> data = response.data;
      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      throw Exception('Error loading favorites: $e');
    }
  }
}