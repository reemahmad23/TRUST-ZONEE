import '../models/branch_model.dart';
import '../models/branch_photo_model.dart';

abstract class PlaceDetailsRemoteDataSource {
  Future<BranchModel> getBranchDetails(int branchId);
  Future<List<BranchPhotoModel>> getBranchPhotos(int branchId);
}
