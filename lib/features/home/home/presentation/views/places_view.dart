import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/localization/app_localizations.dart';
import '../../../../../injection_container.dart';
import '../../../../../utils/shared_data.dart';
import '../manager/branch_cubit/branch_cubit.dart';
import '../manager/branch_cubit/branch_state.dart';
import '../manager/favorite_cubit/favorite_cubit.dart';
import '../manager/favorite_cubit/favorite_state.dart';

class PlacesView extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  const PlacesView({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  State<PlacesView> createState() => _PlacesViewState();
}

class _PlacesViewState extends State<PlacesView> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<BranchCubit>()..getBranches(widget.categoryId)),
        BlocProvider(create: (_) => sl<FavoriteCubit>()..loadFavorites()),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text(widget.categoryName)),
        body: BlocBuilder<BranchCubit, BranchState>(
          builder: (context, state) {
            if (state is BranchLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BranchLoaded) {
              final branches = state.branches;

              if (branches.isEmpty) {
                return Center(child: Text(AppLocalizations.of(context).noPlaceMatchYourSearch));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: branches.length,
                itemBuilder: (_, index) {
                  final branch = branches[index];
                  final place = branch.place;

                  return Card(
                    color: const Color(0xFFDEDDE0),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: const CircleAvatar(
                        radius: 25,
                        backgroundColor: Color(0xFFDEDDE0),
                        backgroundImage: AssetImage("assets/images/photo_2025-06-05_12-03-56.jpg"),
                      ),
                      title: Text(place.name),
                      subtitle: Text(branch.address),
                      onTap: () {
                        setSelectedBranchId(branch.id);
                        context.push('/review/${branch.id}');
                      },
                      trailing: BlocBuilder<FavoriteCubit, FavoriteState>(
                        builder: (context, favState) {
                          bool isFavorite = false;
                          if (favState is FavoriteLoaded) {
                            isFavorite = favState.favorites.any((fav) => fav.branch.id == branch.id);
                          }

                          return IconButton(
                            icon: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite ? Colors.amber : Colors.grey,
                            ),
                            onPressed: () {
                              if (isFavorite) {
                                context.read<FavoriteCubit>().removeFromFavorites(branch.id);
                              } else {
                                context.read<FavoriteCubit>().addToFavorites(branch.id);
                              }
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            } else if (state is BranchError) {
              return Center(child: Text('${AppLocalizations.of(context).error} ${state.message}'));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
