import 'package:flutter/material.dart';
import 'package:movies_app/widgets/movie_card_widget.dart';

class SearchResultsGrid extends StatelessWidget {
  final List movies;

  const SearchResultsGrid({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,

        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      itemCount: movies.length,

      itemBuilder: (context, index) {
        final movie = movies[index];

        return MovieCard(movie: movie);
      },
    );
  }
}
