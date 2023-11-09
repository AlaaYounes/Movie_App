import 'package:movies_app/domain/repository/movie/movie_repository_contract.dart';

class SearchForMovieByNameUseCase {
  MovieRepositoryContract repositoryContract;

  SearchForMovieByNameUseCase({required this.repositoryContract});

  invoke(String name) {
    return repositoryContract.searchForMovieByName(name);
  }
}
