import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/user_profile_repository.dart';
import '../datasource/user_profile_remote_data_source.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  final UserProfileRemoteDataSource remoteDataSource;

  UserProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserProfile1> getUserProfile(String userId) async {
    final model = await remoteDataSource.getUserProfile(userId);
    return UserProfile1(
      id: model.id,
      userName: model.userName,
      email: model.email,
      age: model.age,
      profilePictureUrl: model.profilePictureUrl,
      coverPictureUrl: model.coverPictureUrl,
      registrationDate: model.registrationDate,
      isActive: model.isActive,
      disabilityTypes: model.disabilityTypes.map((e) => DisabilityType(
        id: e.id,
        name: e.name,
      )).toList(),
    );
  }
}
