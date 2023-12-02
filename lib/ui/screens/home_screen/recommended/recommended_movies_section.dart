import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/data/model/movie_response.dart';
import 'package:movies_app/ui/movies_screen/movie_details.dart';
import 'package:movies_app/ui/screens/home_screen/recommended/cubit/recommended_movies_view_model.dart';
import 'package:movies_app/ui/screens/home_screen/recommended/cubit/states.dart';
import 'package:movies_app/ui/screens/home_screen/recommended/recommended_movie_item.dart';
import 'package:movies_app/utils/injection/injection.dart';

class RecommendedMoviesView extends StatefulWidget {
  const RecommendedMoviesView({super.key});

  @override
  State<RecommendedMoviesView> createState() => _RecommendedMoviesViewState();
}

class _RecommendedMoviesViewState extends State<RecommendedMoviesView> {
  RecommendedMoviesViewModel viewModel = RecommendedMoviesViewModel(
    getRecommendedMoviesUseCase: injectGetRecommendedMoviesUseCase(),
    getMoviesFromWatchlistUseCase: injectGetMoviesFromWatchlistUseCase(),
  );

  @override
  void initState() {
    super.initState();
    viewModel.getRecommendedMovies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecommendedMoviesViewModel, RecommendedMoviesState>(
        bloc: viewModel,
        builder: (context, state) {
          if (state is RecommendedMoviesLoadingState) {
            return Center(
                child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ));
          } else if (state is RecommendedMoviesErrorState) {
            return Text(state.errorMessage ?? '');
          } else if (state is RecommendedMoviesSuccessState) {
            List<Results> movieList = state.movies;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15.h),
                  child: Text(
                    'Recommended',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Container(
                  height: 200.h,
                  margin: EdgeInsets.only(top: 15.h),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: movieList.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 7.5,
                    ),
                    itemBuilder: (context, index) => InkWell(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetails(
                                  movieId: movieList[index].id.toString(),
                                  isWatched: false),
                            ),
                          );
                        },
                        child: RecommendedMovieItem(movie: movieList[index])),
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        });
  }
}
