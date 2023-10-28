import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/ui/cubit/app_cubit.dart';
import 'package:movies_app/ui/cubit/app_states.dart';

class app_layout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppLayoutViewModel viewModel = AppLayoutViewModel.get(context);

    return BlocBuilder<AppLayoutViewModel, AppStates>(
      builder: (context, state) => Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'SEARCH'),
            BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'BROWSE'),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('assets/images/watchlist.png'),
                ),
                label: 'WATCHLIST'),
          ],
          onTap: (index) {
            viewModel.changeBottomNavItem(index);
          },
          currentIndex: viewModel.selectedIndex,
        ),
        body: viewModel.screens[viewModel.selectedIndex],
      ),
    );
  }
}
