import 'package:movies_app/data/model/watchList_movie_response.dart';

abstract class MovieLocalDataSource {
  Future<void> addMovieToWatchlist(WatchListMovie watchListMovie);

  Future<List<WatchListMovie>> getMoviesFromWatchList();

  Future<void> deleteWatchListMovie(String id);
}
