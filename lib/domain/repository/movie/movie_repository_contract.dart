import 'package:movies_app/data/model/movie_details_response.dart';
import 'package:movies_app/data/model/movie_response.dart';
import 'package:movies_app/data/model/watchList_movie_response.dart';

abstract class MovieRepositoryContract {
  Future<MovieListResponse> getMovieByCategoryId(String categoryId);

  Future<MovieDetailsResponse> getMovieDetails(String movieId);

  Future<MovieListResponse> searchForMovieByName(String name);

  Future<void> addMovieToWatchlist(WatchListMovie watchListMovie);

  Future<List<WatchListMovie>> getMoviesFromWatchList();

  Future<void> deleteWatchListMovie(String id);
}
