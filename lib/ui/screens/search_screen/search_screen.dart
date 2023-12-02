import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/model/movie_response.dart';
import 'package:movies_app/ui/movies_screen/cubit/movie_cubit.dart';
import 'package:movies_app/ui/movies_screen/cubit/movie_states.dart';
import 'package:movies_app/ui/movies_screen/movie_card.dart';
import 'package:movies_app/ui/movies_screen/movie_details.dart';
import 'package:movies_app/utils/colors.dart';
import 'package:movies_app/utils/injection/injection.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  MovieViewModel viewModel = MovieViewModel(
      searchForMovieByNameUseCase: injectSearchForMovieByNameUseCase(),
      getMoviesFromWatchlistUseCase: injectGetMoviesFromWatchlistUseCase());

  @override
  void initState() {
    super.initState();
    viewModel.searchForMovie(searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              child: TextFormField(
                controller: searchController,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                  fillColor: AppColor.bookmarkColor,
                  filled: true,
                  hintText: 'Search',
                  hintStyle: Theme.of(context).textTheme.bodySmall,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: AppColor.lightGreyColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        25,
                      ),
                      borderSide: BorderSide(color: AppColor.lightGreyColor)),
                  prefixIcon: IconButton(
                    onPressed: () {
                      viewModel.searchForMovie(searchController.text);
                    },
                    icon: Icon(
                      Icons.search,
                      color: AppColor.whiteColor,
                    ),
                  ),
                ),
              ),
            ),
            BlocBuilder<MovieViewModel, MovieStates>(
              bloc: viewModel,
              builder: (context, state) {
                if (state is MovieInitialState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MovieErrorState) {
                  return const Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('movie is not found'),
                          SizedBox(
                            height: 10,
                          ),
                        ]),
                  );
                } else if (state is SearchSuccessState) {
                  List<Results> movieList = state.response;
                  return Expanded(
                    child: ListView.separated(
                      itemCount: movieList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: InkWell(
                            child: MovieCard(
                                imageUrl: movieList[index].posterPath ?? '',
                                movieName: movieList[index].title!,
                                year: movieList[index].releaseDate!),
                            onTap: () async {
                              bool flag = await viewModel
                                  .checkMovie('${movieList[index].id!}');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MovieDetails(
                                    movieId: '${movieList[index].id!}',
                                    isWatched: flag,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                    ),
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/search.png'),
                        const Text('Search for something.'),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
