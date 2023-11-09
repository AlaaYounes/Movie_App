import 'package:movies_app/domain/category/repository/movie/movie_repository_contract.dart';

class GetMovieDetailsUseCase {
  MovieRepositoryContract repositoryContract;

  GetMovieDetailsUseCase({required this.repositoryContract});

  invoke(String movieId) async {
    return await repositoryContract.getMovieDetails(movieId);
  }
}
