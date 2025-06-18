import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trust_zone/features/home/home/presentation/views/widgets/custom_menu_drawer.dart';
import 'package:trust_zone/utils/shared_data.dart';

import '../../../../../core/localization/app_localizations.dart';
import '../manager/branch_cubit/branch_cubit.dart';
import '../manager/branch_cubit/branch_state.dart';
import '../manager/category_cubit/category_cubit.dart';
import '../manager/category_cubit/category_state.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late TextEditingController _searchController;
  String searchText = '';
  int _selectedIndex = 0;

  final List<String> categoryImages = [
    'assets/images/rastaurant.png',
    'assets/images/shopping.png',
    'assets/images/fitness_and_sports.png',
    'assets/images/government_entities.png',
    'assets/images/healthcare_facilities.png',
    'assets/images/entertainment.png',
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    context.read<CategoryCubit>().fetchCategories();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final branchCubit = context.read<BranchCubit>();
    final categoryCubit = context.read<CategoryCubit>();

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        actions: [
        IconButton(
      icon: const Icon(Icons.chat_bubble_outline),
      onPressed: () {
        context.push('/chat-list-screen'); // عدلي المسار حسب اسم شاشة الشات عندك
      },
    ),
    const SizedBox(width: 10),
  ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context).searchBranch,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value.trim();
                });

                if (searchText.isEmpty) {
                  branchCubit.emit(BranchInitial());
                  categoryCubit.fetchCategories();
                } else {
                  branchCubit.searchBranches(query: searchText);
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: Text(
                AppLocalizations.of(context).categories,
                style: TextStyle(
                  color: Color(0xFF1B4965),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: searchText.isEmpty
                ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: BlocBuilder<CategoryCubit, CategoryState>(
                  builder: (context, state) {
                    if (state is CategoryLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is CategoryLoaded) {
                      final categories = state.categories;
                      final images = categoryImages;

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1, 
                        ),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          final image = images.length > index
                              ? images[index]
                              : 'assets/images/default.png';

                          return TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0, end: 1),
                            duration: Duration(milliseconds: 300 + index * 100),
                            builder: (context, value, child) {
                              return Opacity(
                                opacity: value,
                                child: Transform.translate(
                                  offset: Offset(0, 50 * (1 - value)),
                                  child: child!,
                                ),
                              );
                            },
                            child: InkWell(
                              onTap: () {
                                context.push(
                                  '/places-view',
                                  extra: {
                                    'id': category.id,
                                    'name': category.name,
                                  },
                                );
                              },
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                    image: AssetImage(image),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.3),
                                      BlendMode.darken,
                                    ),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  category.name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(1, 1),
                                        blurRadius: 4,
                                        color: Colors.black54,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (state is CategoryError) {
                      return Center(child: Text(state.message));
                    }
                    return const SizedBox();
                  },
                ),
              ),
            )
                : BlocBuilder<BranchCubit, BranchState>(
              builder: (context, state) {
                if (state is BranchLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is BranchLoaded) {
                  if (state.branches.isEmpty) {
                    return  Center(child: Text(AppLocalizations.of(context).noResultFound));
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: state.branches.length,
                    itemBuilder: (context, index) {
                      final branch = state.branches[index];
                      return Card(
                        color: Colors.blue.shade50,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        child: ListTile(
                          leading: const Icon(Icons.location_city, color: Colors.blue),
                          title: Text(branch.place.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                          subtitle: Text(branch.address),
                          onTap: () {
                            setSelectedBranchId(branch.id);
                              print (branch.id);
                              context.push('/review/${branch.id}');
                          },
                        ),
                      );
                    },
                  );
                } else if (state is BranchError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   selectedItemColor: Colors.red,
      //   unselectedItemColor: const Color(0xFF1B4965),
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
      //     BottomNavigationBarItem(icon: Icon(Icons.location_on), label: ''),
      //     BottomNavigationBarItem(icon: Icon(Icons.smart_toy), label: ''),
      //     BottomNavigationBarItem(icon: Icon(Icons.chat), label: ''),
      //   ],
      // ),
    );
  }
}
