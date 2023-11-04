import 'package:movies_app/data/api/api_manager.dart';
import 'package:movies_app/data/model/category_response.dart';
import 'package:movies_app/domain/category/repository/category/category_http_api_dataSource.dart';

class CategoryHttpDataSourceImpl extends CategoryHttpDataSourceContract {
  ApiManager apiManager;

  CategoryHttpDataSourceImpl({required this.apiManager});

  @override
  Future<CategoryResponse> getCategory() async {
    return await apiManager.getCategory();
  }
}
