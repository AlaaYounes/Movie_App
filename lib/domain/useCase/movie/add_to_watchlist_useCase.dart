import 'package:movies_app/data/model/watchList_movie_response.dart';
import 'package:movies_app/domain/repository/movie/movie_repository_contract.dart';

class AddToWatchlistUseCase {
  MovieRepositoryContract repositoryContract;

  AddToWatchlistUseCase({required this.repositoryContract});

  invoke(WatchListMovie watchListMovie) {
    return repositoryContract.addMovieToWatchlist(watchListMovie);
  }
}
