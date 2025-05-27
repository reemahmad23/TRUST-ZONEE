
import '../entities/place_entity.dart';
import '../repo/place_repo.dart';

class GetBranchesByCategoryUseCase {
  final BranchRepository repository;

  GetBranchesByCategoryUseCase(this.repository);

  Future<List<Branch>> call(int categoryId) {
    return repository.getBranchesByCategory(categoryId);
  }



}
class SearchBranchesUseCase {
  final BranchRepository repository;

  SearchBranchesUseCase(this.repository);

  Future<List<Branch>> call(String query, int page, int pageSize) {
    return repository.searchBranches(query, page, pageSize);
  }
}