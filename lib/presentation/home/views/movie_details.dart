import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/busieness_logic/bloc/details/details_bloc.dart';
import 'package:movies_app/busieness_logic/bloc/details/details_state.dart';
import 'package:movies_app/core/confg/colors/app_colors.dart';

import 'package:movies_app/data/model/movie_model.dart';
import 'package:movies_app/data/repository/firestore_fav_repo.dart';
import 'package:movies_app/enums/req_status.dart';
import 'package:movies_app/extension/is_dark.dart';
import 'package:movies_app/extension/sized_box.dart';
import 'package:movies_app/helpers/image_helper.dart';
import 'package:movies_app/presentation/home/views/similer_movies.dart';

class MoviesDetailsView extends StatefulWidget {
  final Movie movie;
  final String heroSource;

  const MoviesDetailsView({
    super.key,
    required this.movie,
    required this.heroSource,
  });

  @override
  State<MoviesDetailsView> createState() => _MoviesDetailsViewState();
}

class _MoviesDetailsViewState extends State<MoviesDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              StreamBuilder<List<Movie>>(
                stream: context.read<FireStoreFavoritesRepo>().watch(),
                builder: (context, snapshot) {
                  final favorites = snapshot.data ?? [];

                  final isFav = favorites.any(
                    (movie) => movie.id == widget.movie.id,
                  );

                  return IconButton(
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                      final repo = context.read<FireStoreFavoritesRepo>();

                      if (isFav) {
                        await repo.remove(widget.movie.id);
                      } else {
                        await repo.add(widget.movie);
                      }
                    },
                  );
                },
              ),
            ],
            expandedHeight: 420,
            pinned: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: context.isDark ? AppColors.primary : AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 15,
                  color: Colors.white,
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: "movie_${widget.movie.id}_${widget.heroSource}",

                    child: SafeMovieImage(path: widget.movie.posterPath),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          (context.isDark ? Colors.black : Colors.white)
                              .withOpacity(.55),
                          Theme.of(context).scaffoldBackgroundColor,
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
                          widget.movie.title,

                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        6.hight,
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18,
                            ),
                            6.hight,
                            Text(
                              "${widget.movie.voteAverage}",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            10.width,
                            Icon(
                              Icons.movie,
                              // color: Colors.white54,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withOpacity(.7),
                              size: 16,
                            ),
                            4.width,
                            Text(
                              "Movie",
                              style: Theme.of(context).textTheme.bodyMedium,
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
                  Text(
                    "Overview",

                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                  10.hight,

                  Text(
                    widget.movie.overview,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(height: 1.5),
                  ),

                  30.hight,

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.play_arrow),
                          label: const Text("Watch"),
                        ),
                      ),
                      12.width,
                    ],
                  ),

                  30.hight,

                  Text(
                    "Movies like this one :",

                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                  12.hight,
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
              builder: (context, state) {
                if (state.status == RequestStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                }

                if (state.status == RequestStatus.failure) {
                  return Center(
                    child: Text(
                      state.error ?? 'Something went wrong',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                if (state.similarMovies.isEmpty) {
                  return Center(
                    child: Text(
                      'No similar movies found',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
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
