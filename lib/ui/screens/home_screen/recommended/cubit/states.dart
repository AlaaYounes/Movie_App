abstract class RecommendedMoviesState {}

class RecommendedMoviesInitialState extends RecommendedMoviesState {}

class RecommendedMoviesLoadingState extends RecommendedMoviesState {}

class RecommendedMoviesErrorState extends RecommendedMoviesState {
  String? errorMessage;

  RecommendedMoviesErrorState({required this.errorMessage});
}

class RecommendedMoviesSuccessState extends RecommendedMoviesState {
  dynamic movies;

  RecommendedMoviesSuccessState({required this.movies});
}
