import 'package:movies_app/domain/repository/movie/movie_repository_contract.dart';

class DeleteFromWatchlistUseCase {
  MovieRepositoryContract repositoryContract;

  DeleteFromWatchlistUseCase({required this.repositoryContract});

  invoke(String id) {
    return repositoryContract.deleteWatchListMovie(id);
  }
}
