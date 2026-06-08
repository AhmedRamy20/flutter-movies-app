import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/busieness_logic/bloc/details/details_bloc.dart';
import 'package:movies_app/busieness_logic/bloc/details/details_state.dart';

import 'package:movies_app/data/model/movie_model.dart';
import 'package:movies_app/helpers/image_helper.dart';
import 'package:movies_app/presentation/views/similer_movies.dart';

class MoviesDetailsView extends StatelessWidget {
  final Movie movie;
  final String heroSource;

  const MoviesDetailsView({
    super.key,
    required this.movie,
    required this.heroSource,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 420,
            pinned: true,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: "movie_${movie.id}_$heroSource",

                    child: SafeMovieImage(path: movie.posterPath),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                          Colors.black,
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 20,
                    left: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "${movie.voteAverage}",
                              style: const TextStyle(color: Colors.white70),
                            ),
                            const SizedBox(width: 10),
                            const Icon(
                              Icons.movie,
                              color: Colors.white54,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              "Movie",
                              style: TextStyle(color: Colors.white54),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Overview",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    movie.overview,
                    style: const TextStyle(color: Colors.white70, height: 1.5),
                  ),

                  const SizedBox(height: 30),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.play_arrow),
                          label: const Text("Watch"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border),
                        label: const Text("Save"),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Movies like this one :",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
              builder: (context, state) {
                if (state.similarMovies.isEmpty) {
                  return const SizedBox(
                    height: 120,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                return SimilarMoviesShape(movies: state.similarMovies);
              },
            ),
          ),
        ],
      ),
    );
  }
}
