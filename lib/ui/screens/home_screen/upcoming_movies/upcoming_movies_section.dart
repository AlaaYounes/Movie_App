import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/data/model/upcoming_movies_response.dart';
import 'package:movies_app/ui/movies_screen/movie_details.dart';
import 'package:movies_app/ui/screens/home_screen/upcoming_movies/upcomig_movies_item.dart';
import 'package:movies_app/utils/injection/injection.dart';

import 'cubit/states.dart';
import 'cubit/upcoming_movies_view_model.dart';

class UpcomingMoviesSection extends StatefulWidget {
  @override
  State<UpcomingMoviesSection> createState() => _UpcomingMoviesSectionState();
}

class _UpcomingMoviesSectionState extends State<UpcomingMoviesSection> {
  UpcomingMoviesViewModel viewModel = UpcomingMoviesViewModel(
      getUpcomingMoviesUseCase: injectGetUpcomingMoviesUseCase());

  @override
  void initState() {
    viewModel.getUpcomingMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpcomingMoviesViewModel, UpcomingMoviesState>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is UpcomingMoviesLoadingState) {
          return Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor));
        } else if (state is UpcomingMoviesErrorState) {
          return Text(state.errorMessage);
        } else if (state is UpcomingMoviesSuccessState) {
          List<UpcomingMovie> movieList = state.movies;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 15.h),
                child: Text('New Releases',
                    style: Theme.of(context).textTheme.titleMedium),
              ),
              Container(
                margin: EdgeInsets.only(top: 15.h),
                height: 200.h,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.movies.length,
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
                        child: UpcomingMoviesItem(movie: state.movies[index]))),
              )
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
