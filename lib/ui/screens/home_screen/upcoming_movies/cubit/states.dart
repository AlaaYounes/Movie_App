import '../../../../../data/model/upcoming_movies_response.dart';

abstract class UpcomingMoviesState {}

class UpcomingMoviesInitialState extends UpcomingMoviesState {}

class UpcomingMoviesLoadingState extends UpcomingMoviesState {}

class UpcomingMoviesErrorState extends UpcomingMoviesState {
  String errorMessage;

  UpcomingMoviesErrorState({required this.errorMessage});
}

class UpcomingMoviesSuccessState extends UpcomingMoviesState {
  List<UpcomingMovie> movies;

  UpcomingMoviesSuccessState({required this.movies});
}
