
import '../entities/category_entity.dart';

abstract class CategoryRepository {
  Future<List<Category>> getCategories();
  Future<Category> getCategoryById(int id);
  Future<void> addCategory(String name);
  Future<void> updateCategory(int id, String name);
  Future<void> deleteCategory(int id);
}
