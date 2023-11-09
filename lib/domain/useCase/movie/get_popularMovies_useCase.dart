import 'package:movies_app/data/model/movie_response.dart';
import 'package:movies_app/domain/repository/movie/movie_repository_contract.dart';

class GetPopularMoviesUseCase {
  MovieRepositoryContract repositoryContract;

  GetPopularMoviesUseCase({required this.repositoryContract});

  Future<MovieListResponse> invoke() {
    return repositoryContract.getPopularMovies();
  }
}
