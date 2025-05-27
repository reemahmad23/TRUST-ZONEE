
import '../../../../../utils/fav_api_service.dart';
import '../../domain/repo/favorite.dart';
import '../models/favorite_place_model.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final ApiService apiService;

  FavoriteRepositoryImpl(this.apiService);

  @override
  Future<void> addFavorite(int branchId) async {
    await apiService.addFavorite(branchId);
  }

  @override
  Future<void> deleteFavorite(int branchId) async {
    await apiService.deleteFavorite(branchId);
  }

  @override
  Future<List<FavoriteModel>> getFavorites() async {
    return await apiService.getFavorites();
  }
}