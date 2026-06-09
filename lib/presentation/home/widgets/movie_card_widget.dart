import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/model/movie_model.dart';
import 'package:movies_app/data/repository/firestore_fav_repo.dart';
import 'package:movies_app/helpers/image_helper.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final bool showTitle;
  final bool useHero;
  final String? heroTag;

  const MovieCard({
    super.key,
    required this.movie,
    this.showTitle = true,
    this.useHero = false,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final repo = context.read<FireStoreFavoritesRepo>();

    Widget imageWidget = SafeMovieImage(path: movie.posterPath);

    if (useHero && heroTag != null) {
      imageWidget = Hero(
        tag: heroTag!,
        child: SafeMovieImage(path: movie.posterPath),
      );
    }

    return StreamBuilder<List<Movie>>(
      stream: repo.watch(),
      builder: (context, snapshot) {
        final favorites = snapshot.data ?? [];

        final isFavorite = favorites.any((m) => m.id == movie.id);

        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Positioned.fill(child: imageWidget),

              Positioned(
                top: 3,
                right: 0,
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: () async {
                    if (isFavorite) {
                      await repo.remove(movie.id);
                    } else {
                      await repo.add(movie);
                    }
                  },
                ),
              ),

              if (showTitle)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.black54,
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      movie.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
