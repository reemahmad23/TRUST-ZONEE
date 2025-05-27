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
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<BranchCubit>()..getBranches(widget.categoryId)),
        BlocProvider(create: (_) => sl<FavoriteCubit>()..loadFavorites()), // إضافة FavoriteCubit

      ],
      child: Scaffold(
        appBar: AppBar(title: Text(widget.categoryName)),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration:  InputDecoration(
                  hintText: AppLocalizations.of(context).search,
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.filter_alt),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchText = value.toLowerCase();
                  });
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<BranchCubit, BranchState>(
                builder: (context, state) {
                  if (state is BranchLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is BranchLoaded) {
                    final filteredBranches = state.branches.where((branch) {
                      final placeName = branch.place.name.toLowerCase();
                      final address = branch.address.toLowerCase();
                      return placeName.contains(searchText) || address.contains(searchText);
                    }).toList();

                    if (filteredBranches.isEmpty) {
                      return Center(child: Text(AppLocalizations.of(context).noPlaceMatchYourSearch));
                    }

                    return ListView.builder(
                      itemCount: filteredBranches.length,
                      itemBuilder: (_, index) {
                        final branch = filteredBranches[index];
                        final place = branch.place;

                        return Card(
                          color: const Color(0xFFDEDDE0),
                          margin: EdgeInsets.all(8),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Color(0xFFDEDDE0),
                              child: Icon(Icons.store, color: Colors.white),
                            ),
                            title: Text(place.name),
                            subtitle: Text(branch.address),
                            onTap: () {
                              setSelectedBranchId(branch.id);
                              print (branch.id);
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
                    return Center(child: Text('${AppLocalizations.of(context).error}+ ${state.message}'));
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
