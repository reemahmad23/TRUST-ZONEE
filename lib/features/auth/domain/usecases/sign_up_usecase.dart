import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/error/failure.dart';
import '../repositories/auth_repo.dart';

class SignUpUseCase {
  final AuthRepo repo;

  SignUpUseCase(this.repo);

  Future<Either<Failure, Map<String, dynamic>>>  call({
    required BuildContext context,
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
    required int age,
    required int disabilityTypeId,
  }) async {
    return await repo.signUp(
      username: username,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      age: age,
      disabilityTypeId: disabilityTypeId, context: context,
    );
  }
}
