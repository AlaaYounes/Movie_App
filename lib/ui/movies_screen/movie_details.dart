import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/api/api_constants.dart';
import 'package:movies_app/data/model/movie_details_response.dart';
import 'package:movies_app/data/model/watchList_movie_response.dart';
import 'package:movies_app/ui/movies_screen/cubit/movie_cubit.dart';
import 'package:movies_app/ui/movies_screen/cubit/movie_states.dart';
import 'package:movies_app/utils/colors.dart';
import 'package:movies_app/utils/injection/injection.dart';

class MovieDetails extends StatefulWidget {
  String movieId;
  bool isWatched;

  MovieDetails({super.key, required this.movieId, required this.isWatched});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  MovieViewModel viewModel = MovieViewModel(
      getMovieDetailsUseCase: injectGetMovieDetailsUseCase(),
      addToWatchlistUseCase: injectAddToWatchlistUseCase(),
      getMoviesFromWatchlistUseCase: injectGetMoviesFromWatchlistUseCase());
  late MovieDetailsResponse movieDetail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getMovieDetails(widget.movieId);
  }

  bool isWatchList = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieViewModel, MovieStates>(
        bloc: viewModel,
        builder: (context, state) {
          if (state is MovieInitialState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.errorMessage),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      viewModel.getMovieDetails(widget.movieId);
                    },
                    child: const Text('try again'),
                  ),
                ],
              ),
            );
          } else if (state is MovieSuccessState) {
            movieDetail = state.response;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  movieDetail.title ?? '',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    width: double.infinity,
                    imageUrl:
                        ApiConstants.baseImage + movieDetail.backdropPath!,
                    fit: BoxFit.fill,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Text(
                                movieDetail.title ?? '',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                movieDetail.releaseDate ?? '',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          viewModel.watchTrailer(movieDetail.homepage!);
                        },
                        child: Row(
                          children: [
                            Text(
                              'Watch trailer',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: AppColor.lightGreyColor),
                            ),
                            const Icon(Icons.play_arrow),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          CachedNetworkImage(
                            height: MediaQuery.of(context).size.height * .25,
                            imageUrl: ApiConstants.baseImage +
                                movieDetail.posterPath!,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                          Positioned(
                            right: MediaQuery.of(context).size.width * .265,
                            bottom: MediaQuery.of(context).size.width * .438,
                            child: InkWell(
                              onTap: () {
                                WatchListMovie movie = WatchListMovie(
                                    mId: movieDetail.id.toString(),
                                    isWatched: movieDetail.isWatched,
                                    title: movieDetail.title,
                                    year: movieDetail.releaseDate,
                                    imagePath: movieDetail.posterPath);
                                viewModel.addToWatchlist(movie);
                                widget.isWatched = true;
                                setState(() {});
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(Icons.bookmark,
                                      color: widget.isWatched == false
                                          ? AppColor.bookmarkColor
                                              .withOpacity(.7)
                                          : AppColor.yellowColor,
                                      size: 50),
                                  Icon(
                                    widget.isWatched == false
                                        ? Icons.add
                                        : Icons.check,
                                    color: AppColor.whiteColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              children: List.generate(
                                movieDetail.genres!.length,
                                (index) => Container(
                                  margin: const EdgeInsets.all(1.5),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: AppColor.greyColor),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    movieDetail.genres![index].name!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          color: AppColor.lightGreyColor,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              movieDetail.overview!,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: AppColor.yellowColor,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${movieDetail.voteAverage!}',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  movieDetail.title!,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    width: double.infinity,
                    imageUrl:
                        ApiConstants.baseImage + movieDetail.backdropPath!,
                    fit: BoxFit.fill,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Text(
                                movieDetail.title!,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                movieDetail.releaseDate!,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          viewModel.watchTrailer(movieDetail.homepage!);
                        },
                        child: Row(
                          children: [
                            Text(
                              'Watch trailer',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: AppColor.lightGreyColor),
                            ),
                            const Icon(Icons.play_arrow),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          CachedNetworkImage(
                            height: MediaQuery.of(context).size.height * .25,
                            imageUrl: ApiConstants.baseImage +
                                movieDetail.posterPath!,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                          Positioned(
                            right: MediaQuery.of(context).size.width * .265,
                            bottom: MediaQuery.of(context).size.width * .438,
                            child: InkWell(
                              onTap: () {
                                WatchListMovie movie = WatchListMovie(
                                    mId: movieDetail.id.toString(),
                                    isWatched: movieDetail.isWatched,
                                    title: movieDetail.title,
                                    year: movieDetail.releaseDate,
                                    imagePath: movieDetail.posterPath);
                                viewModel.addToWatchlist(movie);
                                widget.isWatched = true;
                                setState(() {});
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(Icons.bookmark,
                                      color: widget.isWatched == false
                                          ? AppColor.bookmarkColor
                                              .withOpacity(.7)
                                          : AppColor.yellowColor,
                                      size: 50),
                                  Icon(
                                    widget.isWatched == false
                                        ? Icons.add
                                        : Icons.check,
                                    color: AppColor.whiteColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              children: List.generate(
                                movieDetail.genres!.length,
                                (index) => Container(
                                  margin: const EdgeInsets.all(1.5),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: AppColor.greyColor),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    movieDetail.genres![index].name!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          color: AppColor.lightGreyColor,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              movieDetail.overview!,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: AppColor.yellowColor,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${movieDetail.voteAverage!}',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        });
  }
}
