import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/app_router.dart';
import 'package:movies_app/busieness_logic/bloc/home/home_bloc.dart';
import 'package:movies_app/busieness_logic/bloc/home/home_event.dart';
import 'package:movies_app/busieness_logic/bloc/home/home_state.dart';
import 'package:movies_app/busieness_logic/bloc/search/search_bloc.dart';
import 'package:movies_app/busieness_logic/bloc/search/search_event.dart';
import 'package:movies_app/busieness_logic/bloc/search/search_state.dart';
import 'package:movies_app/constents/routes.dart';
import 'package:movies_app/enums/category.dart';
import 'package:movies_app/widgets/category_grid.dart';
import 'package:movies_app/widgets/category_res.dart';
import 'package:movies_app/widgets/search_widget.dart';
import 'package:movies_app/widgets/trending_widget.dart';

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
      appBar: AppBar(title: const Text("Movies")),

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
          BlocBuilder<SearchBloc, SearchState>(
            builder: (context, searchState) {
              if (searchState.isSearching) {
                return Expanded(
                  child: SearchResultsGrid(movies: searchState.results),
                );
              }

              // if not searching
              return Expanded(
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, homeState) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          TrendingMoviesSection(
                            movies: homeState.trendingMovies,
                            onTap: (movie) {
                              Navigator.pushNamed(
                                context,
                                Routes.details,
                                arguments: MovieDetailsArgs(
                                  movie: movie,
                                  heroSource: 'trending',
                                ),
                              );
                            },
                          ),

                          TabBar(
                            controller: controller,
                            tabs: const [
                              Tab(text: "Now Playing"),
                              Tab(text: "Popular"),
                              Tab(text: "Top Rated"),
                              Tab(text: "Upcoming"),
                            ],
                          ),

                          CategoryGrid(
                            movies: homeState.categoryMovies,
                            onTap: (movie) {
                              Navigator.pushNamed(
                                context,
                                Routes.details,
                                arguments: MovieDetailsArgs(
                                  movie: movie,
                                  heroSource: 'grid',
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
