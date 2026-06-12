import 'package:flutter/material.dart';
import 'package:movies_app/app_router.dart';
import 'package:movies_app/core/constants/routes.dart';

import 'package:movies_app/presentation/home/widgets/movie_card_widget.dart';

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

        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.details,
              arguments: MovieDetailsArgs(
                movie: movie,
                heroSource: 'searching',
              ),
            );
          },
          child: MovieCard(
            movie: movie,
            heroTag: "movie_${movie.id}_searching",
            useHero: true,
            showTitle: true,
          ),
        );
      },
    );
  }
}
