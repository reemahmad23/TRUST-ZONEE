
import '../entities/profile_entity.dart';
import '../repo/profile_repo.dart';

class GetProfileUseCase {
  final ProfileRepo repo;

  GetProfileUseCase(this.repo);

  Future<UserProfile> call() async {
    return await repo.getProfile();
  }
}
