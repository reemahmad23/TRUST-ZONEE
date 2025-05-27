// domain/usecases/upload_profile_image_usecase.dart


import 'package:dartz/dartz.dart';


import '../../../../../core/error/failure.dart';
import '../repo/profile_picture_repo.dart';

class UploadProfileImageUseCase {
  final UserProfileRepository repository;

  UploadProfileImageUseCase(this.repository);

  Future<Either<Failure, String>> call(String filePath) {
    return repository.uploadProfileImage(filePath);
  }
}
