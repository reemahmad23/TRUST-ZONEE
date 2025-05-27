
import '../../domain/entities/profile_entity.dart';
import '../../domain/entities/update_profile_entity.dart';
import '../../domain/repo/profile_repo.dart';
import '../data_sources/profile_remote_data_source.dart';
import '../models/profile_model/update_profile_model.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepoImpl(this.remoteDataSource);
  @override
  Future<UserProfile> getProfile() async {
    final model = await remoteDataSource.getProfile();
    return model.toEntity();
  }

  @override
  Future<void> updateProfile(UpdateProfileEntity entity) async {
    final model = UpdateProfileModel.fromEntity(entity);
    await remoteDataSource.updateProfile(model.toJson());
  }
}
