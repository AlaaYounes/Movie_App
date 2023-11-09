import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/ui/movies_screen/cubit/movie_cubit.dart';
import 'package:movies_app/ui/movies_screen/movie_card.dart';
import 'package:movies_app/ui/movies_screen/movie_details.dart';
import 'package:movies_app/ui/screens/watchlist_screen/cubit.dart';
import 'package:movies_app/ui/screens/watchlist_screen/states.dart';
import 'package:movies_app/utils/colors.dart';

class WatchList extends StatefulWidget {
  const WatchList({super.key});

  @override
  State<WatchList> createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  WatchListViewModel viewModel = WatchListViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getWatchListMovies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchListViewModel, WatchListStates>(
        bloc: viewModel,
        builder: (context, state) {
          if (state is WatchListSuccessState) {
            var response = state.response;
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Scaffold(
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Watchlist',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: response.length,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () async {
                              bool flag = await MovieViewModel()
                                  .checkMovie('${response[index].id!}');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MovieDetails(
                                          movieId: '${response[index].id}',
                                          isWatched: flag)));
                            },
                            child: MovieCard(
                              id: response[index].id,
                              imageUrl: response[index].imagePath!,
                              movieName: response[index].title!,
                              year: response[index].year!,
                              watchlistScreen: true,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Center(
            child: Text(
              'Empty watchlist',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: AppColor.greyColor),
            ),
          );
        });
  }
}
