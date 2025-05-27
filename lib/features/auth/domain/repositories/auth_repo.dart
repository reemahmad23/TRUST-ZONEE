import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/error/failure.dart';

abstract class AuthRepo {
  Future<Either<Failure, Map<String, dynamic>>> login({
    required String email,
    required String password,
    required bool rememberMe,
  });


  Future<Either<Failure, Map<String, dynamic>>> signUp({
    required BuildContext context,
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
    required int age,
    required int disabilityTypeId,
  });
}
