import 'package:movies_app/data/model/movie_details_response.dart';
import 'package:movies_app/data/model/movie_response.dart';
import 'package:movies_app/data/model/upcoming_movies_response.dart';

abstract class MovieHttpDataSource {
  Future<MovieListResponse> getMovieByCategoryId(String categoryId);

  Future<MovieDetailsResponse> getMovieDetails(String movieId);

  Future<MovieListResponse> searchForMovieByName(String name);

  Future<MovieListResponse> getRecommendedMovies();

  Future<MovieListResponse> getPopularMovies();

  Future<UpcomingMoviesResponse> getUpcomingMovies();
}
