import 'package:movies_app/data/api/api_manager.dart';
import 'package:movies_app/data/repository/category/dataSource/category_http_dataSource_impl.dart';
import 'package:movies_app/data/repository/category/repository/category_repository_impl.dart';
import 'package:movies_app/data/repository/movie/dataSource/movie_http_daataSource_impl.dart';
import 'package:movies_app/data/repository/movie/repository/Movie_repository_impl.dart';
import 'package:movies_app/domain/category/repository/category/category_http_api_dataSource.dart';
import 'package:movies_app/domain/category/repository/category/category_repository_contract.dart';
import 'package:movies_app/domain/category/repository/movie/movie_http_api_dataSource.dart';
import 'package:movies_app/domain/category/repository/movie/movie_repository_contract.dart';
import 'package:movies_app/domain/category/useCase/category/get_category.dart';
import 'package:movies_app/domain/category/useCase/movie/get_movieDetails.dart';
import 'package:movies_app/domain/category/useCase/movie/get_movie_by_categoryId.dart';

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

MovieHttpDataSourceContract injectMovieHttpDataSourceContract() {
  return MovieHttpDataSourceImpl(apiManager: ApiManager.getInstance());
}

MovieRepositoryContract injectMovieRepositoryContract() {
  return MovieRepositoryImpl(
      dataSourceContract: injectMovieHttpDataSourceContract());
}

GetMovieByCategoryIdUseCase injectGetMovieByCategoryIdUseCase() {
  return GetMovieByCategoryIdUseCase(
      repositoryContract: injectMovieRepositoryContract());
}

GetMovieDetailsUseCase injectGetMovieDetailsUseCase() {
  return GetMovieDetailsUseCase(
      repositoryContract: injectMovieRepositoryContract());
}
