import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/domain/useCase/movie/get_movies_from_watchlist_useCase.dart';
import 'package:movies_app/domain/useCase/movie/get_recommendedMovies_useCase.dart';
import 'package:movies_app/ui/screens/home_screen/recommended/cubit/states.dart';

class RecommendedMoviesViewModel extends Cubit<RecommendedMoviesState> {
  GetRecommendedMoviesUseCase getRecommendedMoviesUseCase;
  GetMoviesFromWatchlistUseCase getMoviesFromWatchlistUseCase;

  RecommendedMoviesViewModel({
    required this.getRecommendedMoviesUseCase,
    required this.getMoviesFromWatchlistUseCase,
  }) : super(RecommendedMoviesInitialState());

  void getRecommendedMovies() async {
    try {
      emit(RecommendedMoviesLoadingState());
      var response = await getRecommendedMoviesUseCase.invoke();
      if (response.success == false) {
        emit(
            RecommendedMoviesErrorState(errorMessage: response.status_message));
      } else {
        emit(RecommendedMoviesSuccessState(movies: response.results));
      }
    } catch (e) {
      emit(RecommendedMoviesErrorState(errorMessage: e.toString()));
    }
  }
}
