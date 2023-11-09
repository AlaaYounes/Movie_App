import 'package:movies_app/data/api/api_manager.dart';
import 'package:movies_app/data/model/movie_details_response.dart';
import 'package:movies_app/data/model/movie_response.dart';
import 'package:movies_app/domain/category/repository/movie/movie_http_api_dataSource.dart';

class MovieHttpDataSourceImpl extends MovieHttpDataSourceContract {
  ApiManager apiManager;

  MovieHttpDataSourceImpl({required this.apiManager});

  @override
  Future<MovieListResponse> getMovieByCategoryId(String categoryId) async {
    return await ApiManager.getInstance().getMovieByCategoryId(categoryId);
  }

  Future<MovieDetailsResponse> getMovieDetails(String movieId) async {
    return await ApiManager.getInstance().getMovieDetails(movieId);
  }
}
