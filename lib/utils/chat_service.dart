import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatApiService {
  final Dio dio;

  ChatApiService(this.dio) {
    dio.options.baseUrl = 'https://trustzone.azurewebsites.net/api';
    dio.options.headers['accept'] = 'text/plain';
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ));
  }

  Future<Response> get(String path) async {
    return await dio.get(path);
  }

  Future<Response> post(String path, {dynamic data}) async {
    return await dio.post(path, data: data);
  }
}
