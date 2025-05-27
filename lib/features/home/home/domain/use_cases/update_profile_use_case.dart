
import '../entities/update_profile_entity.dart';
import '../repo/profile_repo.dart';

class UpdateProfileUseCase {
  final ProfileRepo repo;

  UpdateProfileUseCase(this.repo);

  Future<void> call(UpdateProfileEntity entity) async {
    return await repo.updateProfile(entity);
  }
}
