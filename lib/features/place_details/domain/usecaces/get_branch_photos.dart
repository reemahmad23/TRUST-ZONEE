import '../entities/branch_photo.dart';
import '../repositories/place_details_repository.dart';

class GetBranchPhotosUseCase {
  final PlaceDetailsRepository repository;

  GetBranchPhotosUseCase(this.repository);

  Future<List<BranchPhotoEntity>> call(int branchId) {
    return repository.getBranchPhotos(branchId);
  }
}
