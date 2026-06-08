import 'package:flutter/material.dart';
import 'package:movies_app/presentation/views/fav_view.dart';
import 'package:movies_app/presentation/views/home_view.dart';

class BottomNavEntry extends StatefulWidget {
  const BottomNavEntry({super.key});

  @override
  State<BottomNavEntry> createState() => _BottomNavEntryState();
}

class _BottomNavEntryState extends State<BottomNavEntry> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: const [HomeView(), FavoritesView()],
      ),

      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.favorite), label: "Favorites"),
        ],
        selectedIndex: selectedIndex,
        onDestinationSelected: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
      ),
    );
  }
}
