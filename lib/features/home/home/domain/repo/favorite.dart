
import '../../data/models/favorite_place_model.dart';

abstract class FavoriteRepository {
  Future<void> addFavorite(int branchId);
  Future<void> deleteFavorite(int branchId);
  Future<List<FavoriteModel>> getFavorites();
}