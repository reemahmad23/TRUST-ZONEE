
import '../../../domain/entities/category_entity.dart';
import 'category_state.dart';

class SingleCategoryLoaded extends CategoryState {
  final Category category;

  SingleCategoryLoaded(this.category);
}
