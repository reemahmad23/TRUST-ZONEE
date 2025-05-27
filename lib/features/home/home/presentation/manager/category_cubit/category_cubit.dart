import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/get_category_id.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetCategoryByIdUseCase getCategoryByIdUseCase;
  final AddCategoryUseCase addCategoryUseCase;
  final UpdateCategoryUseCase updateCategoryUseCase;
  final DeleteCategoryUseCase deleteCategoryUseCase;

  CategoryCubit({
    required this.getCategoriesUseCase,
    required this.getCategoryByIdUseCase,
    required this.addCategoryUseCase,
    required this.updateCategoryUseCase,
    required this.deleteCategoryUseCase,
  }) : super(CategoryInitial());

  Future<void> fetchCategories() async {
    emit(CategoryLoading());
    final result = await getCategoriesUseCase();
    emit(CategoryLoaded(result));
  }

  Future<void> createCategory(String name) async {
    emit(CategoryLoading());
    await addCategoryUseCase(name);
    await fetchCategories(); // refresh list
  }

  Future<void> editCategory(int id, String name) async {
    emit(CategoryLoading());
    await updateCategoryUseCase(id, name);
    await fetchCategories(); // refresh list
  }

  Future<void> removeCategory(int id) async {
    emit(CategoryLoading());
    await deleteCategoryUseCase(id);
    await fetchCategories(); // refresh list
  }
}
