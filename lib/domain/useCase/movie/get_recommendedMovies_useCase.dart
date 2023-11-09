import 'package:movies_app/data/model/movie_response.dart';
import 'package:movies_app/domain/repository/movie/movie_repository_contract.dart';

class GetRecommendedMoviesUseCase {
  MovieRepositoryContract repositoryContract;

  GetRecommendedMoviesUseCase({required this.repositoryContract});

  Future<MovieListResponse> invoke() {
    return repositoryContract.getRecommendedMovies();
  }
}
