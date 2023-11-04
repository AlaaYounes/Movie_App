import 'package:movies_app/data/model/category_response.dart';
import 'package:movies_app/domain/category/repository/category/category_repository_contract.dart';

class GetCategoryUseCase {
  CategoryRepositoryContract repositoryContract;

  GetCategoryUseCase({required this.repositoryContract});

  Future<CategoryResponse> invoke() async {
    return await repositoryContract.getCategory();
  }
}
