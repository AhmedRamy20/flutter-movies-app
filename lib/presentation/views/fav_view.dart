import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_app/app_router.dart';
import 'package:movies_app/busieness_logic/bloc/home/home_bloc.dart';
import 'package:movies_app/busieness_logic/bloc/home/home_event.dart';
import 'package:movies_app/constents/routes.dart';
import 'package:movies_app/data/model/movie_hive_model.dart';
import 'package:movies_app/extension/to_movie_model.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<MovieHiveModel>('favorites');

    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<MovieHiveModel> box, _) {
          // final favorites = box.values.toList();
          //? prev dub
          final favorites = {for (var m in box.values) m.id: m}.values.toList();

          if (favorites.isEmpty) {
            return const Center(child: Text("No favorites yet.."));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.65,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: favorites.length,

            itemBuilder: (context, index) {
              final movie = favorites[index];

              final imageUrl = movie.posterPath == null
                  ? null
                  : "https://image.tmdb.org/t/p/w500${movie.posterPath}";

              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.details,
                    arguments: MovieDetailsArgs(
                      movie: movie.toMovie(),
                      heroSource: 'favorites',
                    ),
                  );
                },
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(16),
                            child: imageUrl == null
                                ? Container(
                                    color: Colors.grey,
                                    child: const Icon(
                                      Icons.image_not_supported,
                                    ),
                                  )
                                : Image.network(imageUrl, fit: BoxFit.cover),
                          ),
                        ),
                        Text(
                          movie.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),

                    Positioned(
                      top: 6,
                      right: 6,
                      child: GestureDetector(
                        onTap: () {
                          box.delete(movie.id);
                          context.read<HomeBloc>().add(SyncFavoritesFromHive());
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
