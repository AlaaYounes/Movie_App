import 'package:movies_app/data/model/watchList_movie_response.dart';
import 'package:movies_app/domain/repository/movie/movie_repository_contract.dart';

class GetMoviesFromWatchlistUseCase {
  MovieRepositoryContract repositoryContract;

  GetMoviesFromWatchlistUseCase({required this.repositoryContract});

  Future<List<WatchListMovie>> invoke() {
    return repositoryContract.getMoviesFromWatchList();
  }
}
