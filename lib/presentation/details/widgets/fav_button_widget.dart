import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/model/movie_model.dart';
import 'package:movies_app/data/repository/firestore_fav_repo.dart';

class FavoriteButtonWidget extends StatelessWidget {
  final Movie movie;

  const FavoriteButtonWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Movie>>(
      stream: context.read<FireStoreFavoritesRepo>().watch(),
      builder: (context, snapshot) {
        final favorites = snapshot.data ?? [];
        final isFav = favorites.any((movy) => movy.id == movie.id);

        return IconButton(
          icon: Icon(
            isFav ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
          ),
          onPressed: () async {
            final repo = context.read<FireStoreFavoritesRepo>();
            if (isFav) {
              await repo.remove(movie.id);
            } else {
              await repo.add(movie);
            }
          },
        );
      },
    );
  }
}
