
import '../entities/profile_entity.dart';
import '../entities/update_profile_entity.dart';

abstract class ProfileRepo {
  Future<UserProfile> getProfile();
  Future<void> updateProfile(UpdateProfileEntity entity);
}
