import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/firebase/local_firebase.dart';
import 'package:movies_app/data/model/watchList_movie_response.dart';
import 'package:movies_app/domain/category/useCase/movie/get_movieDetails.dart';
import 'package:movies_app/domain/category/useCase/movie/get_movie_by_categoryId.dart';
import 'package:movies_app/ui/movies_screen/cubit/movie_states.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieViewModel extends Cubit<MovieStates> {
  GetMovieByCategoryIdUseCase? getMovieByCategoryIdUseCase;
  GetMovieDetailsUseCase? getMovieDetailsUseCase;

  MovieViewModel(
      {this.getMovieByCategoryIdUseCase, this.getMovieDetailsUseCase})
      : super(MovieInitialState());

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

  Future<bool> checkMovie(String id) async {
    List<WatchListMovie> movieList =
        await FirebaseManager.getMoviesFromFireStore();
    for (var element in movieList) {
      print(id.runtimeType);
      print(element.id.runtimeType);
      print('$id ${element.id}');
      if (id == element.id.toString()) {
        return true;
      }
    }
    return false;
  }

  addToWatchlist(WatchListMovie movie) async {
    dynamic flag = await checkMovie('${movie.id!}');
    print('======================');
    print(flag);
    print('======================');

    if (flag == false) {
      FirebaseManager.addMovieToFireStore(movie);
      print(movie.title);
      emit(MovieAddedToFireStore());
    }
  }
}
