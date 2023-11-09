import 'package:movies_app/data/model/movie_response.dart';
import 'package:movies_app/domain/repository/movie/movie_repository_contract.dart';

class GetMovieByCategoryIdUseCase {
  MovieRepositoryContract repositoryContract;

  GetMovieByCategoryIdUseCase({required this.repositoryContract});

  Future<MovieListResponse> invoke(String categoryId) async {
    return await repositoryContract.getMovieByCategoryId(categoryId);
  }
}
