

import '../../../../../utils/profile_api_service.dart';
import '../../domain/entities/place_entity.dart';
import '../../domain/repo/place_repo.dart';

class BranchRepositoryImpl implements BranchRepository {
  final ProfileApiService apiService;

  BranchRepositoryImpl({required this.apiService});

  @override
  Future<List<Branch>> getBranchesByCategory(int categoryId) async {
    final branchModels = await apiService.getBranchesByCategory(categoryId);

    return branchModels.map((model) {
      return Branch(
        id: model.id,
        address: model.address,
        website: model.website,
        phone: model.phone,
        createdAt: model.createdAt,
        place: Place(
          name: model.place.name,
          categoryId: model.place.categoryId,
          latitude: model.place.latitude,
          longitude: model.place.longitude,
          details: model.place.details,
          features: model.place.features
              .map((f) => Feature(
                    featureId: f.featureId,
                    featureName: f.featureName,
                    description: f.description,
                  ))
              .toList(),
        ),
      );
    }).toList();
  }
  @override
  Future<List<Branch>> searchBranches(String query, int page, int pageSize) async {
    final branchModels = await apiService.searchBranches(
      query: query,
      page: page,
      pageSize: pageSize,
    );

    return branchModels.map((model) {
      return Branch(
        id: model.id,
        address: model.address,
        website: model.website,
        phone: model.phone,
        createdAt: model.createdAt,
        place: Place(
          name: model.place.name,
          categoryId: model.place.categoryId,
          latitude: model.place.latitude,
          longitude: model.place.longitude,
          details: model.place.details,
          features: model.place.features.map((f) {
            return Feature(
              featureId: f.featureId,
              featureName: f.featureName,
              description: f.description,
            );
          }).toList(),
        ),
      );
    }).toList();
  }
}
