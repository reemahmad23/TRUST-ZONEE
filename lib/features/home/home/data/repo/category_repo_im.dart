
import '../../domain/entities/category_entity.dart';
import '../../domain/repo/category_repo.dart';
import '../data_sources/category_remote_data_source.dart';


class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Category>> getCategories() async {
    final models = await remoteDataSource.getCategories();
    return models.map((e) => Category(id: e.id, name: e.name)).toList();
  }


  @override
  Future<void> addCategory(String name) => remoteDataSource.addCategory(name);

  @override
  Future<void> deleteCategory(int id) => remoteDataSource.deleteCategory(id);

  @override
  Future<void> updateCategory(int id, String name) =>
      remoteDataSource.updateCategory(id, name);

  @override
  Future<Category> getCategoryById(int id) async {
    final model = await remoteDataSource.getCategoryById(id);
    return Category(id: model.id, name: model.name);
  }



}
