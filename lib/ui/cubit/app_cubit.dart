import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/ui/cubit/app_states.dart';
import 'package:movies_app/ui/screens/browse_screen/browse_screen.dart';
import 'package:movies_app/ui/screens/home_screen/home_screen.dart';
import 'package:movies_app/ui/screens/search_screen/search_screen.dart';
import 'package:movies_app/ui/screens/watchlist_screen/watchlist_screen.dart';

class AppLayoutViewModel extends Cubit<AppStates> {
  static AppLayoutViewModel get(context) => BlocProvider.of(context);

  AppLayoutViewModel() : super(AppInitialState());
  int selectedIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    SearchScreen(),
    BrowseScreen(),
    WatchList(),
  ];

  changeBottomNavItem(index) {
    selectedIndex = index;
    emit(AppChangeBottomNavItemState());
  }
}
