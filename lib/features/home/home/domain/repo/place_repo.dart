

import '../entities/place_entity.dart';

abstract class BranchRepository {
  Future<List<Branch>> getBranchesByCategory(int categoryId);
  Future<List<Branch>> searchBranches(String query, int page, int pageSize);
}
