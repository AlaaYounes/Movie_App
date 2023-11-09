import 'package:movies_app/data/model/upcoming_movies_response.dart';
import 'package:movies_app/domain/repository/movie/movie_repository_contract.dart';

class GetUpcomingMoviesUseCase {
  MovieRepositoryContract repositoryContract;

  GetUpcomingMoviesUseCase({required this.repositoryContract});

  Future<UpcomingMoviesResponse> invoke() {
    return repositoryContract.getUpcomingMovies();
  }
}
