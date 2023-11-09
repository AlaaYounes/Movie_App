import 'package:bloc/bloc.dart';
import 'package:movies_app/domain/useCase/movie/get_upcomingMovies_useCase.dart';
import 'package:movies_app/ui/screens/home_screen/upcoming_movies/cubit/states.dart';

class UpcomingMoviesViewModel extends Cubit<UpcomingMoviesState> {
  GetUpcomingMoviesUseCase getUpcomingMoviesUseCase;

  UpcomingMoviesViewModel({required this.getUpcomingMoviesUseCase})
      : super(UpcomingMoviesInitialState());

  void getUpcomingMovies() async {
    try {
      var response = await getUpcomingMoviesUseCase.invoke();
      if (response.status_message != null) {
        emit(UpcomingMoviesErrorState(
            errorMessage: response.status_message ?? ''));
      } else {
        emit(UpcomingMoviesSuccessState(movies: response.upcomingMovies ?? []));
      }
    } catch (e) {
      emit(UpcomingMoviesErrorState(errorMessage: e.toString()));
    }
  }
}
