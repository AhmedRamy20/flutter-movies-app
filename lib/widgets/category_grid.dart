import 'package:flutter/material.dart';
import 'package:movies_app/widgets/movie_card_widget.dart';

class CategoryGrid extends StatelessWidget {
  final List movies;

  const CategoryGrid({super.key, required this.movies});

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
        return MovieCard(movie: movies[index]);
      },
    );
  }
}
