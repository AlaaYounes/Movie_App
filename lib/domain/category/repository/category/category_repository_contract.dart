import 'package:movies_app/data/model/category_response.dart';

abstract class CategoryRepositoryContract {
  Future<CategoryResponse> getCategory();
}
