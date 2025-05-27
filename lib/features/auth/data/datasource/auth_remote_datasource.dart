import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
    required bool rememberMe,
  });


  Future<Map<String, dynamic>> signUp({
    required BuildContext context,
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
    required int age,
    required int disabilityTypeId,
  });

}
