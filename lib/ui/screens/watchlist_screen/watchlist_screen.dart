import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/ui/movies_screen/movie_card.dart';
import 'package:movies_app/ui/screens/watchlist_screen/cubit.dart';
import 'package:movies_app/ui/screens/watchlist_screen/states.dart';
import 'package:movies_app/utils/colors.dart';

class WatchList extends StatefulWidget {
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
            print(response.length);
            return Scaffold(
              body: Column(
                children: [
                  Text(
                    'Watchlist',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (contex, index) => MovieCard(
                            imageUrl: response[index].imagePath!,
                            movieName: response[index].title!,
                            year: response[index].year!),
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: response.length),
                  ),
                ],
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
