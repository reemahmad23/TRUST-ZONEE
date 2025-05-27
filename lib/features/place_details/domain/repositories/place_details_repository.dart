import '../entities/branch_entity.dart';
import '../entities/branch_photo.dart';

abstract class PlaceDetailsRepository {
  Future<BranchEntity> getBranchDetails(int branchId);
  Future<List<BranchPhotoEntity>> getBranchPhotos(int branchId);
}
