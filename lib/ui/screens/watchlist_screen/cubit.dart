import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/model/watchList_movie_response.dart';
import 'package:movies_app/domain/useCase/movie/delete_from_watchlist_useCase.dart';
import 'package:movies_app/domain/useCase/movie/get_movies_from_watchlist_useCase.dart';
import 'package:movies_app/ui/screens/watchlist_screen/states.dart';

class WatchListViewModel extends Cubit<WatchListStates> {
  GetMoviesFromWatchlistUseCase? getMoviesFromWatchlistUseCase;
  DeleteFromWatchlistUseCase? deleteFromWatchlistUseCase;

  WatchListViewModel(
      {this.getMoviesFromWatchlistUseCase, this.deleteFromWatchlistUseCase})
      : super(WatchListInitialState());

  Future getWatchListMovies() async {
    List<WatchListMovie> response =
        await getMoviesFromWatchlistUseCase!.invoke();
    emit(WatchListSuccessState(response: response));
  }

  void deleteWatchListMovie(String id) {
    deleteFromWatchlistUseCase!.invoke(id);
    getWatchListMovies();
  }
}
