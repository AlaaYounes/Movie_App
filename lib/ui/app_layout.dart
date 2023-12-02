import 'package:flutter/material.dart';
import 'package:movies_app/ui/screens/browse_screen/browse_screen.dart';
import 'package:movies_app/ui/screens/home_screen/home_screen.dart';
import 'package:movies_app/ui/screens/search_screen/search_screen.dart';
import 'package:movies_app/ui/screens/watchlist_screen/watchlist_screen.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  int selectedIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const BrowseScreen(),
    const WatchList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            selectedIndex = index;
            setState(() {});
          },
          currentIndex: selectedIndex),
      body: screens[selectedIndex],
    );
  }
}
