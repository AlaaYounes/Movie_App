import 'package:movies_app/data/model/movie_details_response.dart';
import 'package:movies_app/data/model/movie_response.dart';
import 'package:movies_app/domain/category/repository/movie/movie_http_api_dataSource.dart';
import 'package:movies_app/domain/category/repository/movie/movie_repository_contract.dart';

class MovieRepositoryImpl extends MovieRepositoryContract {
  MovieHttpDataSourceContract dataSourceContract;

  MovieRepositoryImpl({required this.dataSourceContract});

  @override
  Future<MovieListResponse> getMovieByCategoryId(String categoryId) {
    return dataSourceContract.getMovieByCategoryId(categoryId);
  }

  Future<MovieDetailsResponse> getMovieDetails(String movieId) {
    return dataSourceContract.getMovieDetails(movieId);
  }
}
