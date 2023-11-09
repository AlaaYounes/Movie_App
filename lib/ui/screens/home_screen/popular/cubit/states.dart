abstract class PopularMoviesState {}

class PopularMoviesInitialState extends PopularMoviesState {}

class PopularMoviesLoadingState extends PopularMoviesState {}

class PopularMoviesErrorState extends PopularMoviesState {
  String errorMessage;

  PopularMoviesErrorState({required this.errorMessage});
}

class PopularMoviesSuccessState extends PopularMoviesState {
  dynamic movies;

  PopularMoviesSuccessState({required this.movies});
}
