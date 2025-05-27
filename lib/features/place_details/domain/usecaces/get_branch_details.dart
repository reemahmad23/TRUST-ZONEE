
import '../entities/branch_entity.dart';
import '../repositories/place_details_repository.dart';

class GetBranchDetailsUseCase {
  final PlaceDetailsRepository repository;

  GetBranchDetailsUseCase(this.repository);

  Future<BranchEntity> call(int branchId) {
    return repository.getBranchDetails(branchId);
  }
}
