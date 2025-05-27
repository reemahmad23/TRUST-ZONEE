import '../repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';

class LoginUseCase {
  final AuthRepo repo;

  LoginUseCase(this.repo);

  Future<Either<Failure, Map<String, dynamic>>>  call({required String email, required String password}) {
    return repo.login(email: email, password: password, rememberMe: true);
  }
}
