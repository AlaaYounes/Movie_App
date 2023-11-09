import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/model/movie_response.dart';
import 'package:movies_app/ui/movies_screen/cubit/movie_cubit.dart';
import 'package:movies_app/ui/movies_screen/cubit/movie_states.dart';
import 'package:movies_app/ui/movies_screen/movie_card.dart';
import 'package:movies_app/ui/movies_screen/movie_details.dart';
import 'package:movies_app/utils/injection/injection.dart';

class MovieContainer extends StatefulWidget {
  String categoryId;
  String categoryName;

  MovieContainer({required this.categoryId, required this.categoryName});

  @override
  State<MovieContainer> createState() => _MovieContainerState();
}

class _MovieContainerState extends State<MovieContainer> {
  MovieViewModel viewModel = MovieViewModel(
      getMovieByCategoryIdUseCase: injectGetMovieByCategoryIdUseCase());

  @override
  void initState() {
    super.initState();
    viewModel.getMovieByCategoryId(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    viewModel.getMovieByCategoryId(widget.categoryId);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryName,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: BlocBuilder<MovieViewModel, MovieStates>(
          bloc: viewModel,
          builder: (context, state) {
            if (state is MovieInitialState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MovieErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.errorMessage!),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        viewModel.getMovieByCategoryId(widget.categoryId);
                      },
                      child: Text('try again'),
                    ),
                  ],
                ),
              );
            } else if (state is MovieSuccessState) {
              List<Results> movieList = state.response;
              return Scaffold(
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: ListView.separated(
                        itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MovieDetails(
                                              movieId:
                                                  '${movieList[index].id!}',
                                            )));
                              },
                              child: MovieCard(
                                  imageUrl: movieList[index].posterPath!,
                                  movieName: movieList[index].title!,
                                  year: movieList[index].releaseDate!),
                            ),
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: movieList.length),
                  ),
                ),
              );
            } else {
              return Center(
                child: Container(),
              );
            }
          }),
    );
  }
}
