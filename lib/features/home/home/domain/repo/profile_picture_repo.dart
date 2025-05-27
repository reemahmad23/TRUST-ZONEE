// domain/repositories/user_profile_repository.dart


import 'package:dartz/dartz.dart';
import 'package:trust_zone/core/error/failure.dart';

abstract class UserProfileRepository {
  Future<Either<Failure, String>> uploadProfileImage(String filePath);
}
