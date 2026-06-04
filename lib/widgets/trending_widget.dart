import 'package:flutter/material.dart';
import 'package:movies_app/data/model/movie_model.dart';
import 'package:movies_app/widgets/movie_card_widget.dart';

class TrendingMoviesSection extends StatelessWidget {
  final List<Movie> movies;
  final void Function(int index) onTap;

  const TrendingMoviesSection({
    super.key,
    required this.movies,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return const SizedBox(
        height: 220,
        child: Center(child: Text("No trending movies")),
      );
    }
    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: movies.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final movie = movies[index];

          return GestureDetector(
            onTap: () => onTap(index),

            child: SizedBox(width: 140, child: MovieCard(movie: movie)),
          );
        },
      ),
    );
  }
}
