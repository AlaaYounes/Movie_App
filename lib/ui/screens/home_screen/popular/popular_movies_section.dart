import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/data/api/api_constants.dart';
import 'package:movies_app/data/model/movie_response.dart';
import 'package:movies_app/ui/movies_screen/movie_details.dart';
import 'package:movies_app/utils/colors.dart';
import 'package:movies_app/utils/injection/injection.dart';

import 'cubit/popular_movies_view_model.dart';
import 'cubit/states.dart';

class PopularMoviesSection extends StatefulWidget {
  const PopularMoviesSection({super.key});

  @override
  State<PopularMoviesSection> createState() => _PopularMoviesSectionState();
}

class _PopularMoviesSectionState extends State<PopularMoviesSection> {
  PopularMoviesViewModel viewModel = PopularMoviesViewModel(
      getPopularMoviesUseCase: injectGetPopularMoviesUseCase());
  bool isWatched = true;

  @override
  void initState() {
    super.initState();
    viewModel.getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularMoviesViewModel, PopularMoviesState>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is PopularMoviesLoadingState) {
          return Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor),
          );
        } else if (state is PopularMoviesErrorState) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else if (state is PopularMoviesSuccessState) {
          List<Results> movieList = state.movies;

          return SizedBox(
            height: 400.h,
            child: ImageSlideshow(
                initialPage: 0,
                isLoop: true,
                autoPlayInterval: 3000,
                indicatorColor: AppColor.yellowColor,
                children: movieList
                    .map(
                      (movie) => Stack(
                        children: [
                          CachedNetworkImage(
                            fit: BoxFit.contain,
                            imageUrl:
                                ApiConstants.baseImage + movie.backdropPath!,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              height: 220,
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MovieDetails(
                                              movieId: movie.id.toString(),
                                              isWatched: false),
                                        ),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: ApiConstants.baseImage +
                                            movie.posterPath!,
                                        placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          movie.title!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          movie.releaseDate!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                    .toList()),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
