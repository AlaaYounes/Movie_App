import 'package:movies_app/data/api/api_manager.dart';
import 'package:movies_app/data/firebase/local_firebase.dart';
import 'package:movies_app/data/repository/category/dataSource/category_http_dataSource_impl.dart';
import 'package:movies_app/data/repository/category/repository/category_repository_impl.dart';
import 'package:movies_app/data/repository/movie/dataSource/movie_http_dataSource_impl.dart';
import 'package:movies_app/data/repository/movie/dataSource/movie_local_dataSource_impl.dart';
import 'package:movies_app/data/repository/movie/repository/Movie_repository_impl.dart';
import 'package:movies_app/domain/repository/category/category_http_api_dataSource.dart';
import 'package:movies_app/domain/repository/category/category_repository_contract.dart';
import 'package:movies_app/domain/repository/movie/movie_http_api_dataSource.dart';
import 'package:movies_app/domain/repository/movie/movie_local_dataSource.dart';
import 'package:movies_app/domain/repository/movie/movie_repository_contract.dart';
import 'package:movies_app/domain/useCase/category/get_category.dart';
import 'package:movies_app/domain/useCase/movie/add_to_watchlist_useCase.dart';
import 'package:movies_app/domain/useCase/movie/delete_from_watchlist_useCase.dart';
import 'package:movies_app/domain/useCase/movie/get_movieDetails.dart';
import 'package:movies_app/domain/useCase/movie/get_movie_by_categoryId.dart';
import 'package:movies_app/domain/useCase/movie/get_movies_from_watchlist_useCase.dart';

CategoryHttpDataSourceContract injectHttpDataSourceContract() {
  return CategoryHttpDataSourceImpl(apiManager: ApiManager.getInstance());
}

CategoryRepositoryContract injectCategoryRepositoryContract() {
  return CategoryRepositoryImpl(
      dataSourceContract: injectHttpDataSourceContract());
}

GetCategoryUseCase injectGetCategoryUseCase() {
  return GetCategoryUseCase(
      repositoryContract: injectCategoryRepositoryContract());
}

MovieHttpDataSource injectMovieHttpDataSource() {
  return MovieHttpDataSourceImpl(apiManager: ApiManager.getInstance());
}

MovieLocalDataSource injectMovieLocalDataSource() {
  return MovieLocalDataSourceImpl(
      firebaseManager: FirebaseManager.getInstance());
}

MovieRepositoryContract injectMovieRepositoryContract() {
  return MovieRepositoryImpl(
      httpDataSource: injectMovieHttpDataSource(),
      localDataSource: injectMovieLocalDataSource());
}

GetMovieByCategoryIdUseCase injectGetMovieByCategoryIdUseCase() {
  return GetMovieByCategoryIdUseCase(
      repositoryContract: injectMovieRepositoryContract());
}

GetMovieDetailsUseCase injectGetMovieDetailsUseCase() {
  return GetMovieDetailsUseCase(
      repositoryContract: injectMovieRepositoryContract());
}

GetMoviesFromWatchlistUseCase injectGetMoviesFromWatchlistUseCase() {
  return GetMoviesFromWatchlistUseCase(
      repositoryContract: injectMovieRepositoryContract());
}

AddToWatchlistUseCase injectAddToWatchlistUseCase() {
  return AddToWatchlistUseCase(
      repositoryContract: injectMovieRepositoryContract());
}

DeleteFromWatchlistUseCase injectDeleteFromWatchlistUseCase() {
  return DeleteFromWatchlistUseCase(
      repositoryContract: injectMovieRepositoryContract());
}
