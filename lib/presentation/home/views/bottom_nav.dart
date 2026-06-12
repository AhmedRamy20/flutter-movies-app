import 'package:flutter/material.dart';
import 'package:movies_app/core/confg/colors/app_colors.dart';
import 'package:movies_app/extension/is_dark.dart';
import 'package:movies_app/presentation/home/views/fav_view.dart';
import 'package:movies_app/presentation/home/views/home_view.dart';

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
        elevation: 0,
        height: 65,
        backgroundColor: context.isDark
            ? AppColors.bottomNavColor
            : Colors.white,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        indicatorColor: AppColors.primary.withOpacity(0.15),
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        selectedIndex: selectedIndex,
        onDestinationSelected: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded, color: AppColors.primary),
            label: "Home",
          ),
          const NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            selectedIcon: Icon(
              Icons.favorite_rounded,
              color: AppColors.primary,
            ),
            label: "Favorites",
          ),
        ],
      ),
    );
  }
}
