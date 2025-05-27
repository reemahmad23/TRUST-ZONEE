import '../entities/user_profile.dart';
import '../repositories/user_profile_repository.dart';

class GetUserProfile {
  final UserProfileRepository repository;

  GetUserProfile(this.repository);

  Future<UserProfile1> call(String userId) async {
    return await repository.getUserProfile(userId);
  }
}
