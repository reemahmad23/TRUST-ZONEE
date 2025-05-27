import '../entities/user_profile.dart';

abstract class UserProfileRepository {
  Future<UserProfile1> getUserProfile(String userId);
}
