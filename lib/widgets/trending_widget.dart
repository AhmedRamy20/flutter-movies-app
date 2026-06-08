import 'package:flutter/material.dart';
import 'package:movies_app/data/model/movie_model.dart';
import 'package:movies_app/widgets/movie_card_widget.dart';

class TrendingMoviesSection extends StatefulWidget {
  final List<Movie>? movies;
  final void Function(Movie movie) onTap;

  const TrendingMoviesSection({
    super.key,
    required this.movies,
    required this.onTap,
  });

  @override
  State<TrendingMoviesSection> createState() => _TrendingMoviesSectionState();
}

class _TrendingMoviesSectionState extends State<TrendingMoviesSection> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();

    _controller = PageController(viewportFraction: 0.45);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final safeMovies = widget.movies ?? [];

    if (safeMovies.isEmpty) {
      return const SizedBox(
        height: 220,
        child: Center(child: Text("No trending movies")),
      );
    }

    return SizedBox(
      height: 240,
      child: PageView.builder(
        controller: _controller,
        padEnds: false,
        physics: const BouncingScrollPhysics(),
        itemCount: safeMovies.length,
        itemBuilder: (context, index) {
          final movie = safeMovies[index];

          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              double scale = 1.0;

              if (_controller.position.haveDimensions) {
                final diff = (_controller.page! - index).abs();
                scale = (1 - diff * 0.25).clamp(0.85, 1.0);
              }

              return Transform.scale(
                scale: scale,
                child: GestureDetector(
                  onTap: () => widget.onTap(movie),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: MovieCard(
                      movie: movie,
                      heroTag: "movie_${movie.id}_trending",
                      useHero: true,
                      showTitle: false,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
