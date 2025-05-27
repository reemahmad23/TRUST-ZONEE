


import '../../data/models/favorite_place_model.dart';
import '../repo/favorite.dart';

class AddFavoriteUseCase {
  final FavoriteRepository repository;

  AddFavoriteUseCase(this.repository);

  Future<void> call(int branchId) async {
    await repository.addFavorite(branchId);
  }
}

class DeleteFavoriteUseCase {
  final FavoriteRepository repository;

  DeleteFavoriteUseCase(this.repository);

  Future<void> call(int branchId) async {
    await repository.deleteFavorite(branchId);
  }
}

class GetFavoritesUseCase {
  final FavoriteRepository repository;

  GetFavoritesUseCase(this.repository);

  Future<List<FavoriteModel>> call() async {
    return await repository.getFavorites();
  }
}