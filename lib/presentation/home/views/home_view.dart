import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/busieness_logic/bloc/home/home_bloc.dart';
import 'package:movies_app/busieness_logic/bloc/home/home_event.dart';
import 'package:movies_app/busieness_logic/bloc/home/home_state.dart';
import 'package:movies_app/busieness_logic/bloc/search/search_bloc.dart';
import 'package:movies_app/busieness_logic/bloc/search/search_event.dart';
import 'package:movies_app/busieness_logic/bloc/search/search_state.dart';
import 'package:movies_app/busieness_logic/bloc/theme/theme_cubit.dart';
import 'package:movies_app/busieness_logic/bloc/auth/auth_bloc.dart';
import 'package:movies_app/busieness_logic/bloc/auth/auth_event.dart';

import 'package:movies_app/enums/category.dart';
import 'package:movies_app/enums/menu_choices.dart';
import 'package:movies_app/extension/is_dark.dart';
import 'package:movies_app/extension/sized_box.dart';
import 'package:movies_app/presentation/home/views/widgets/build_category_section.dart';
import 'package:movies_app/presentation/home/views/widgets/build_trending_section.dart';
import 'package:movies_app/presentation/home/widgets/category_res.dart';
import 'package:movies_app/presentation/home/widgets/search_widget.dart';
import 'package:movies_app/utils/dialogs/logout_dialog.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  final searchController = TextEditingController();
  Timer? _debounce;

  final categories = [
    MovieCategory.nowPlaying,
    MovieCategory.popular,
    MovieCategory.topRated,
    MovieCategory.upcoming,
  ];

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 4, vsync: this);

    context.read<HomeBloc>().add(LoadTrendingMovies());
    context.read<HomeBloc>().add(LoadCategoryMovies(categories[0]));

    controller.addListener(() {
      if (controller.indexIsChanging) {
        context.read<HomeBloc>().add(
          LoadCategoryMovies(categories[controller.index]),
        );
      }
    });
  }

  void onSearchChanged(String value) {
    if (value.isEmpty) {
      context.read<SearchBloc>().add(ClearSearchEvent());
      return;
    }

    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<SearchBloc>().add(SearchMoviesEvent(value));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies"),
        backgroundColor: Colors.transparent,
        actions: [
          PopupMenuButton<MenuChoice>(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: MenuChoice.logout,
                child: const Text("Sign out"),
              ),

              PopupMenuItem(
                value: MenuChoice.theme,
                child: Row(
                  children: [
                    Icon(context.isDark ? Icons.light_mode : Icons.dark_mode),
                    8.width,
                    Text(context.isDark ? "Light Mode" : "Dark Mode"),
                  ],
                ),
              ),
            ],

            offset: Offset(0, 60),
            onSelected: (value) async {
              switch (value) {
                case MenuChoice.logout:
                  final showLogout = await showLogOutDialog(context);

                  if (showLogout) {
                    if (!context.mounted) return;
                    context.read<AuthBloc>().add(const AuthEventLoggingOut());
                  }
                  break;
                case MenuChoice.theme:
                  context.read<ThemeCubit>().updateTheme(
                    context.isDark ? ThemeMode.light : ThemeMode.dark,
                  );
                  break;
              }
            },
          ),
        ],
      ),

      body: Column(
        children: [
          // search ui
          BlocBuilder<SearchBloc, SearchState>(
            builder: (context, searchState) {
              return MovieSearchBar(
                controller: searchController,
                onChanged: onSearchChanged,
                onClear: () {
                  searchController.clear();
                  context.read<SearchBloc>().add(ClearSearchEvent());
                },
                isSearching: searchState.isSearching,
              );
            },
          ),

          // result for serch
          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, searchState) {
                if (searchState.isSearching) {
                  return SearchResultsGrid(movies: searchState.results);
                }

                return BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        buildTrendingSection(state, context),
                        const SizedBox(height: 10),
                        Expanded(
                          child: buildCategorySection(
                            state,
                            context,
                            controller,
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
