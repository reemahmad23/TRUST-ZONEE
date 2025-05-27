import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../data/models/favorite_place_model.dart';
import '../manager/favorite_cubit/favorite_cubit.dart';
import '../manager/favorite_cubit/favorite_state.dart';

class FavoritePlacesScreen extends StatelessWidget {
  const FavoritePlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(
          AppLocalizations.of(context).favoritePlaces,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoriteLoaded) {
            final favorites = state.favorites;

            if (favorites.isEmpty) {
              return  Center(child: Text(AppLocalizations.of(context).noFavoritePlaceYet));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final FavoriteModel favorite = favorites[index];
                final place = favorite.branch.place;
                return InkWell(
                  onTap: () {
                    // Navigate to details screen and pass place ID
                    Navigator.pushNamed(
                      context,
                      '/placeDetails',
                      arguments: favorite.branch.id,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFE6E4E4),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        leading: Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            color: Color(0xFF153B56),
                            shape: BoxShape.circle,
                          ),
                        ),
                        title: Text(
                          favorite.branch.place.name.isNotEmpty
                              ? favorite.branch.place.name
                              : AppLocalizations.of(context).noNameYet,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              place.details,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black54),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              favorite.branch.address,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black45),
                            ),
                          ],
                        ),
                        trailing:
                            Icon(Icons.star, color: Colors.amber, size: 20),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is FavoriteError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
