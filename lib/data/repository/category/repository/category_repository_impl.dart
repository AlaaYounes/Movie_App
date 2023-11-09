import 'package:movies_app/data/model/category_response.dart';
import 'package:movies_app/domain/repository/category/category_http_api_dataSource.dart';
import 'package:movies_app/domain/repository/category/category_repository_contract.dart';

class CategoryRepositoryImpl extends CategoryRepositoryContract {
  CategoryHttpDataSourceContract dataSourceContract;

  CategoryRepositoryImpl({required this.dataSourceContract});

  @override
  Future<CategoryResponse> getCategory() async {
    return await dataSourceContract.getCategory();
  }
}
