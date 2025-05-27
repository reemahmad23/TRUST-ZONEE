
import '../../domain/entities/branch_entity.dart';
import '../../domain/entities/branch_photo.dart';
import '../../domain/repositories/place_details_repository.dart';
import '../datasources/place_details_remote_data_source.dart';

class PlaceDetailsRepositoryImpl implements PlaceDetailsRepository {
  final PlaceDetailsRemoteDataSource remoteDataSource;

  PlaceDetailsRepositoryImpl(this.remoteDataSource);

  @override
  Future<BranchEntity> getBranchDetails(int branchId) {
    return remoteDataSource.getBranchDetails(branchId);
  }

  @override
  Future<List<BranchPhotoEntity>> getBranchPhotos(int branchId) {
    return remoteDataSource.getBranchPhotos(branchId);
  }
}
