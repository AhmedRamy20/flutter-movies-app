import 'package:flutter/material.dart';
import 'package:movies_app/data/model/movie_model.dart';
import 'package:movies_app/presentation/home/widgets/movie_card_widget.dart';

class CategoryGrid extends StatelessWidget {
  final List movies;
  final Function(Movie) onTap;
  const CategoryGrid({super.key, required this.movies, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: movies.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.65,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        final movie = movies[index];

        return GestureDetector(
          onTap: () => onTap(movie),
          child: MovieCard(
            movie: movie,
            heroTag: "movie_${movie.id}_grid",
            useHero: true,
            showTitle: true,
          ),
        );
      },
    );
  }
}
