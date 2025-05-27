import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/token_helper.dart';
import 'auth_remote_datasource.dart';


class DioException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic responseData;
  final RequestOptions requestOptions;

  DioException({
    required this.message,
    this.statusCode,
    this.responseData,
    required this.requestOptions,
  });

  @override
  String toString() => 'DioException: $message (Code: $statusCode)';
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    try {
      final response = await dio.post(
        'https://trustzone.azurewebsites.net/api/User/login',
        data: {
          'email': email,
          'password': password,
          'rememberMe': rememberMe,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;

        // ✅ حفظ التوكن
        final token = data['token'];
        if (token != null) {
          await TokenHelper.saveToken(token);
          print('✅ Token saved successfully: $token');
        }else {
          print('❌ Token is null. It was not saved.');
        }

        return data;
      } else if (response.statusCode == 400) {
        throw DioError(
          requestOptions: response.requestOptions,
          error: AppStrings.invalidEmailOrPassword,
        );
      } else {
        throw DioError(
          requestOptions: response.requestOptions,
          error: AppStrings.unexpectedError,
        );
      }
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode == 400) {
        throw DioError(
          requestOptions: e.requestOptions,
          error: AppStrings.invalidEmailOrPassword,
        );
      } else if (e.response != null && e.response!.statusCode == 500) {
        throw DioError(
          requestOptions: e.requestOptions,
          error: AppStrings.serverErrorOccurred,
        );
      } else {
        throw DioError(
          requestOptions: e.requestOptions,
          error: e.message,
        );
      }
    }
  }

  @override
  Future<Map<String, dynamic>> signUp({
    required BuildContext context,
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
    required int age,
    required int disabilityTypeId,
  }) async {
    try {
      final response = await dio.post(
        'https://trustzone.azurewebsites.net/api/User/register-user',
        data: {
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
          "userName": username,
          "age": age,
          "disabilityTypeId": disabilityTypeId,
        },
      );

      if (response.statusCode == 201) {
        return response.data;
      } else {
        throw DioException(
          message: "Unexpected error",
          statusCode: response.statusCode,
          responseData: response.data,
          requestOptions: response.requestOptions,
        );
      }
    } on DioError catch (e) {
      final statusCode = e.response?.statusCode;

      if (statusCode == 400) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Email Already Registered"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              ),
            ],
          ),
        );
        throw DioException(
          message: "",
          statusCode: 400,
          responseData: e.response?.data,
          requestOptions: e.requestOptions,
        );
      } else if (statusCode == 409) {
        throw DioException(
          message: "Email already exists.",
          statusCode: 409,
          responseData: e.response?.data,
          requestOptions: e.requestOptions,
        );
      } else {
        throw DioException(
          message: e.message ?? "Something went wrong.",
          statusCode: statusCode,
          responseData: e.response?.data,
          requestOptions: e.requestOptions,
        );
      }
    }
  }
}
