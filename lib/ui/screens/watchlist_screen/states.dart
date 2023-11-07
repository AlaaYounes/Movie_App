import 'package:movies_app/data/model/watchList_movie_response.dart';

class WatchListStates {}

class WatchListInitialState extends WatchListStates {}

class WatchListSuccessState extends WatchListStates {
  List<WatchListMovie> response;

  WatchListSuccessState({required this.response});
}

class WatchListDeleteMovieState extends WatchListStates {}
