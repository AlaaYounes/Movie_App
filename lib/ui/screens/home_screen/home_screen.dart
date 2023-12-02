import 'package:flutter/material.dart';
import 'package:movies_app/ui/screens/home_screen/popular/popular_movies_section.dart';
import 'package:movies_app/ui/screens/home_screen/recommended/recommended_movies_section.dart';
import 'package:movies_app/ui/screens/home_screen/upcoming_movies/upcoming_movies_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PopularMoviesSection(),
                UpcomingMoviesSection(),
                RecommendedMoviesView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
