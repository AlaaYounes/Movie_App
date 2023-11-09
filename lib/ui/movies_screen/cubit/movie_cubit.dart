import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/model/watchList_movie_response.dart';
import 'package:movies_app/domain/useCase/movie/add_to_watchlist_useCase.dart';
import 'package:movies_app/domain/useCase/movie/get_movieDetails.dart';
import 'package:movies_app/domain/useCase/movie/get_movie_by_categoryId.dart';
import 'package:movies_app/domain/useCase/movie/get_movies_from_watchlist_useCase.dart';
import 'package:movies_app/ui/movies_screen/cubit/movie_states.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieViewModel extends Cubit<MovieStates> {
  GetMovieByCategoryIdUseCase? getMovieByCategoryIdUseCase;
  GetMovieDetailsUseCase? getMovieDetailsUseCase;
  GetMoviesFromWatchlistUseCase? getMoviesFromWatchlistUseCase;
  AddToWatchlistUseCase? addToWatchlistUseCase;

  MovieViewModel({
    this.getMovieByCategoryIdUseCase,
    this.getMovieDetailsUseCase,
    this.getMoviesFromWatchlistUseCase,
    this.addToWatchlistUseCase,
  }) : super(MovieInitialState());

  getMovieByCategoryId(String categoryId) async {
    var response = await getMovieByCategoryIdUseCase!.invoke(categoryId);
    try {
      if (response.success = false) {
        emit(MovieErrorState(errorMessage: response.status_message!));
      } else {
        emit(MovieSuccessState(response: response.results!));
      }
    } catch (e) {
      emit(MovieErrorState(errorMessage: e.toString()));
    }
  }

  getMovieDetails(String movieId) async {
    var response = await getMovieDetailsUseCase!.invoke(movieId);
    try {
      if (response.success = false) {
        emit(MovieErrorState(errorMessage: response.status_message!));
      } else {
        emit(MovieSuccessState(response: response));
      }
    } catch (e) {
      emit(MovieErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> watchTrailer(String link) async {
    final Uri url = Uri.parse(link);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
    emit(MovieWatchTrailerState());
  }

  Future<bool> checkMovie(String mId) async {
    List<WatchListMovie> movieList =
        await getMoviesFromWatchlistUseCase!.invoke();
    for (var element in movieList) {
      print(mId.runtimeType);
      print(element.mId.runtimeType);
      print('$mId ${element.mId}');
      if (mId == element.mId.toString()) {
        return true;
      }
    }
    return false;
  }

  addToWatchlist(WatchListMovie movie) async {
    dynamic flag = await checkMovie(movie.mId!);
    print('======================');
    print(flag);
    print('======================');

    if (flag == false) {
      addToWatchlistUseCase!.invoke(movie);
      print(movie.title);
    }
  }
}
