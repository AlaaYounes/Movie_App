import 'package:movies_app/data/model/movie_details_response.dart';
import 'package:movies_app/data/model/movie_response.dart';
import 'package:movies_app/data/model/watchList_movie_response.dart';
import 'package:movies_app/domain/repository/movie/movie_http_api_dataSource.dart';
import 'package:movies_app/domain/repository/movie/movie_local_dataSource.dart';
import 'package:movies_app/domain/repository/movie/movie_repository_contract.dart';

class MovieRepositoryImpl implements MovieRepositoryContract {
  MovieHttpDataSource? httpDataSource;
  MovieLocalDataSource? localDataSource;

  MovieRepositoryImpl({this.httpDataSource, this.localDataSource});

  @override
  Future<MovieListResponse> getMovieByCategoryId(String categoryId) {
    return httpDataSource!.getMovieByCategoryId(categoryId);
  }

  @override
  Future<MovieDetailsResponse> getMovieDetails(String movieId) {
    return httpDataSource!.getMovieDetails(movieId);
  }

  @override
  Future<void> addMovieToWatchlist(WatchListMovie watchListMovie) {
    return localDataSource!.addMovieToWatchlist(watchListMovie);
  }

  @override
  Future<void> deleteWatchListMovie(String id) async {
    return localDataSource!.deleteWatchListMovie(id);
  }

  @override
  Future<List<WatchListMovie>> getMoviesFromWatchList() {
    return localDataSource!.getMoviesFromWatchList();
  }

  @override
  Future<MovieListResponse> searchForMovieByName(String name) {
    return httpDataSource!.searchForMovieByName(name);
  }
}
