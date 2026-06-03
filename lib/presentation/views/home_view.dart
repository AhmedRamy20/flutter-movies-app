import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/busieness_logic/bloc/movie_bloc.dart';
import 'package:movies_app/busieness_logic/bloc/movie_event.dart';
import 'package:movies_app/busieness_logic/bloc/movie_state.dart';
import 'package:movies_app/presentation/views/movie_details.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  final TextEditingController searchController = TextEditingController();
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
        searchController.clear(); // exit search mode safely
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

    if (_debounce?.isActive ?? false) _debounce!.cancel();

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

      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MoviesLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MoviesErrorState) {
            return Center(child: Text(state.error));
          }

          if (state is MoviesLoadedState) {
            final isSearching = state.isSearching == true;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),

                  child: TextField(
                    controller: searchController,
                    onChanged: onSearchChanged,
                    decoration: InputDecoration(
                      hintText: "Search movies...",
                      prefixIcon: const Icon(Icons.search),

                      suffixIcon: BlocBuilder<MovieBloc, MovieState>(
                        builder: (context, state) {
                          if (state is MoviesLoadedState && state.isSearching) {
                            return IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                searchController.clear();
                                context.read<MovieBloc>().add(
                                  ClearSearchEvent(),
                                );
                              },
                            );
                          }
                          return const SizedBox();
                        },
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),

                if (isSearching)
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(12),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.65,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                      itemCount: state.searchResults?.length ?? 0,
                      itemBuilder: (context, index) {
                        final movie = state.searchResults![index];

                        return SafeMovieImage(path: movie.posterPath);
                      },
                    ),
                  )
                else
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 220,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              itemCount: state.trendingMovies?.length ?? 0,
                              separatorBuilder: (_, _) =>
                                  const SizedBox(width: 12),
                              itemBuilder: (context, index) {
                                final movie = state.trendingMovies![index];

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => MoviesDetailsView(),
                                      ),
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: SafeMovieImage(
                                      path: movie.posterPath,
                                      width: 140,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 10),

                          TabBar(
                            controller: controller,
                            isScrollable: true,
                            tabs: const [
                              Tab(text: "Now Playing"),
                              Tab(text: "Popular"),
                              Tab(text: "Top Rated"),
                              Tab(text: "Upcoming"),
                            ],
                          ),

                          const SizedBox(height: 10),

                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(12),
                            itemCount: state.categoryMoviesList?.length ?? 0,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 0.65,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                ),
                            itemBuilder: (context, index) {
                              final movie = state.categoryMoviesList![index];

                              return SafeMovieImage(path: movie.posterPath);
                            },
                          ),
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

class SafeMovieImage extends StatelessWidget {
  final String? path;
  final double? width;

  const SafeMovieImage({super.key, required this.path, this.width});

  @override
  Widget build(BuildContext context) {
    if (path == null || path!.isEmpty) {
      return Container(
        width: width,
        color: Colors.grey.shade300,
        child: const Icon(Icons.image_not_supported),
      );
    }

    final url = "https://image.tmdb.org/t/p/w500$path";

    return Image.network(
      url,
      width: width,
      fit: BoxFit.cover,

      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          color: Colors.grey.shade300,
          child: const Icon(Icons.broken_image),
        );
      },

      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const Center(child: CircularProgressIndicator(strokeWidth: 2));
      },
    );
  }
}

enum MovieCategory { nowPlaying, popular, topRated, upcoming }
