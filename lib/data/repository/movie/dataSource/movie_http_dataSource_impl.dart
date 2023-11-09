import 'package:movies_app/data/api/api_manager.dart';
import 'package:movies_app/data/model/movie_details_response.dart';
import 'package:movies_app/data/model/movie_response.dart';
import 'package:movies_app/data/model/upcoming_movies_response.dart';
import 'package:movies_app/domain/repository/movie/movie_http_api_dataSource.dart';

class MovieHttpDataSourceImpl implements MovieHttpDataSource {
  ApiManager apiManager;

  MovieHttpDataSourceImpl({required this.apiManager});

  @override
  Future<MovieListResponse> getMovieByCategoryId(String categoryId) async {
    return await ApiManager.getInstance().getMovieByCategoryId(categoryId);
  }

  @override
  Future<MovieDetailsResponse> getMovieDetails(String movieId) async {
    return await ApiManager.getInstance().getMovieDetails(movieId);
  }

  @override
  Future<MovieListResponse> searchForMovieByName(String name) async {
    return await ApiManager.getInstance().searchForMovieByName(name);
  }

  @override
  Future<MovieListResponse> getPopularMovies() async {
    return await apiManager.getPopularMovies();
  }

  @override
  Future<MovieListResponse> getRecommendedMovies() async {
    return await apiManager.getRecommendedMovies();
  }

  @override
  Future<UpcomingMoviesResponse> getUpcomingMovies() async {
    return await apiManager.getUpcomingMovies();
  }
}
