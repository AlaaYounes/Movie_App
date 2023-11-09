import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/domain/useCase/movie/get_popularMovies_useCase.dart';
import 'package:movies_app/ui/screens/home_screen/popular/cubit/states.dart';

class PopularMoviesViewModel extends Cubit<PopularMoviesState> {
  GetPopularMoviesUseCase getPopularMoviesUseCase;

  PopularMoviesViewModel({required this.getPopularMoviesUseCase})
      : super(PopularMoviesInitialState());

  void getPopularMovies() async {
    try {
      var response = await getPopularMoviesUseCase.invoke();
      if (response.success == false) {
        emit(
          PopularMoviesErrorState(errorMessage: response.status_message ?? ''),
        );
      } else {
        emit(PopularMoviesSuccessState(movies: response.results));
      }
    } catch (e) {
      emit(PopularMoviesErrorState(errorMessage: e.toString()));
    }
  }
}
