import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/busieness_logic/bloc/movie_bloc.dart';
import 'package:movies_app/busieness_logic/bloc/movie_event.dart';
import 'package:movies_app/busieness_logic/bloc/movie_state.dart';
import 'package:movies_app/enums/category.dart';
import 'package:movies_app/presentation/views/movie_details.dart';
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

    context.read<MovieBloc>().add(LoadTrendingMovies());

    controller.addListener(() {
      if (controller.indexIsChanging) {
        searchController.clear();
        context.read<MovieBloc>().add(
          GetMoviesBasedOnCategoryEvent(categories[controller.index]),
        );
      }
    });
  }

  void onSearchChanged(String value) {
    if (value.isEmpty) {
      context.read<MovieBloc>().add(ClearSearchEvent());
      return;
    }

    _debounce?.cancel();
    // debouncer is for the search not firing an api call every time we write a word
    //and it wait 500 mil and then fire event that call the api with the value
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<MovieBloc>().add(SearchMoviesEvent(value));
    });
  }

  @override
  void dispose() {
    controller.dispose();
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Movies")),

      body: BlocConsumer<MovieBloc, MovieState>(
        listener: (context, state) {
          if (state is MoviesLoadedState && state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },

        builder: (context, state) {
          if (state is MoviesLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MoviesErrorState) {
            return const Center(child: Text("Error"));
          }

          if (state is MoviesLoadedState) {
            final isSearching = state.isSearching;

            return Column(
              children: [
                MovieSearchBar(
                  controller: searchController,
                  onChanged: onSearchChanged,
                  onClear: () {
                    searchController.clear();
                    context.read<MovieBloc>().add(ClearSearchEvent());
                  },
                  isSearching: isSearching,
                ),

                if (isSearching)
                  Expanded(
                    child: SearchResultsGrid(movies: state.searchResults),
                  )
                else
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TrendingMoviesSection(
                            movies: state.trendingMovies,
                            onTap: (i) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => MoviesDetailsView(),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 10),

                          TabBar(
                            controller: controller,
                            tabs: const [
                              Tab(text: "Now Playing"),
                              Tab(text: "Popular"),
                              Tab(text: "Top Rated"),
                              Tab(text: "Upcoming"),
                            ],
                          ),

                          CategoryGrid(movies: state.categoryMoviesList),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
