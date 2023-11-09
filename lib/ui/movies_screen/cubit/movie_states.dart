abstract class MovieStates {}

class MovieInitialState extends MovieStates {}

class MovieErrorState extends MovieStates {
  String errorMessage;

  MovieErrorState({required this.errorMessage});
}

class MovieSuccessState extends MovieStates {
  dynamic response;

  MovieSuccessState({required this.response});
}

class MovieWatchTrailerState extends MovieStates {}

class MovieAddedToFireStore extends MovieStates {}

class SearchSuccessState extends MovieStates {
  dynamic response;

  SearchSuccessState({required this.response});
}
