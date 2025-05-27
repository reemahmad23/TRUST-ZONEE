import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_cases/favorite_usecase.dart';
import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final AddFavoriteUseCase addFavorite;
  final DeleteFavoriteUseCase deleteFavorite;
  final GetFavoritesUseCase getFavorites;

  FavoriteCubit({
    required this.addFavorite,
    required this.deleteFavorite,
    required this.getFavorites,
  }) : super(FavoriteInitial());

  void loadFavorites() async {
    emit(FavoriteLoading());
    try {
      print("🔄 Loading favorites...");
      final data = await getFavorites();
      print("✅ Favorites loaded successfully.");
      emit(FavoriteLoaded(data));
    } catch (e) {
      print("❌ Failed to load favorites: $e");
      emit(FavoriteError('Failed to load favorites'));
    }
  }

  void addToFavorites(int branchId) async {
    print("📥 Adding branchId $branchId to favorites...");
    try {
      await addFavorite(branchId);
      print("✅ branchId $branchId added to favorites.");
      loadFavorites();
    } catch (e) {
      print("❌ Failed to add branchId $branchId to favorites: $e");
      emit(FavoriteError('Failed to add favorite'));
    }
  }

  void removeFromFavorites(int branchId) async {
    print("🗑 Removing branchId $branchId from favorites...");
    try {
      await deleteFavorite(branchId);
      print("✅ branchId $branchId removed from favorites.");
      loadFavorites();
    } catch (e) {
      print("❌ Failed to remove branchId $branchId from favorites: $e");
      emit(FavoriteError('Failed to remove favorite'));
    }
  }
}