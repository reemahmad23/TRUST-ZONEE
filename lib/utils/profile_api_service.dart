import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/home/home/data/models/place.dart';


class ProfileApiService {

  final Dio dio;

  ProfileApiService(Object object)
      : dio = Dio(BaseOptions(
    baseUrl: 'https://trustzone.azurewebsites.net', // تحديد base URL
    headers: {
      'Content-Type': 'application/json',
    },
  ));
// 📥 Helper to get token dynamically
  Future<Map<String, String>> _getHeaders({Map<String, String>? extra}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    return {
      'Authorization': 'Bearer $token',
      ...?extra,
    };
  }
  // GET request
  Future<Response> get(String url, {Map<String, dynamic>? headers}) async {
    final dynamicHeaders = await _getHeaders(extra: headers?.cast<String, String>());
    return await dio.get(

      url,
      options: Options(headers: dynamicHeaders),
    );
  }

  // PUT request
  Future<Response> put(String url, {dynamic data, Map<String, dynamic>? headers}) async {final dynamicHeaders = await _getHeaders(extra: headers?.cast<String, String>());
  return await dio.put(
    url,
    data: data,
    options: Options(headers: dynamicHeaders),
  );
  }

  Future<String> getSasUrl(String fileName) async {
    final response = await dio.get('/api/UserProfile/upload-image?fileName=$fileName');
    return response.data['sasUrl']; // حسب الريسبونس
  }
  Future<void> uploadImageToSas(String sasUrl, File imageFile) async {
    await dio.put(
      sasUrl,
      data: imageFile.openRead(),
      options: Options(
        headers: {
          'x-ms-blob-type': 'BlockBlob',
          'Content-Type': 'image/jpeg',
        },
      ),
    );
  }
  Future<List<BranchModel>> getBranchesByCategory(int categoryId) async {
    final headers = await _getHeaders(extra: {'accept': '*/*'});

    final response = await dio.get(
      '/api/Branch/category/$categoryId',
      options: Options(headers: headers),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((json) => BranchModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load branches');
    }
  }
  Future<List<BranchModel>> searchBranches({required String query, required int page, required int pageSize}) async {
    final response = await dio.get(
      '/api/Branch/search',
      queryParameters: {
        'Query': query,
        'page': 1,
        'pageSize': 10,
      },
    );
    print('Raw response: ${response.data}'); // ✅ هنا تطبع الـ response

    if (response.statusCode == 200) {
      final data = response.data as List;
      return data.map((json) => BranchModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load branches from search');
    }
  }
}





