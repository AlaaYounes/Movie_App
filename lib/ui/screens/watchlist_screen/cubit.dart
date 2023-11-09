import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/firebase/local_firebase.dart';
import 'package:movies_app/data/model/watchList_movie_response.dart';
import 'package:movies_app/ui/screens/watchlist_screen/states.dart';

class WatchListViewModel extends Cubit<WatchListStates> {
  WatchListViewModel() : super(WatchListInitialState());

  Future getWatchListMovies() async {
    List<WatchListMovie> response =
        await FirebaseManager.getMoviesFromFireStore();
    emit(WatchListSuccessState(response: response));
  }

  Future<void> deleteWatchListMovie(String id) async {
    FirebaseManager.deleteWatchListMovie(id);
    emit(WatchListDeleteMovieState());
  }
}
