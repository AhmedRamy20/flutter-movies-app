import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movies_app/busieness_logic/bloc/details/details_bloc.dart';
import 'package:movies_app/busieness_logic/bloc/details/details_state.dart';
import 'package:movies_app/constents/apis.dart';
import 'package:movies_app/core/confg/colors/app_colors.dart';
import 'package:movies_app/data/model/movie_model.dart';
import 'package:movies_app/data/repository/firestore_fav_repo.dart';
import 'package:movies_app/data/repository/movies_repo.dart';
import 'package:movies_app/enums/req_status.dart';
import 'package:movies_app/extension/is_dark.dart';
import 'package:movies_app/extension/sized_box.dart';
import 'package:movies_app/helpers/image_helper.dart';
import 'package:movies_app/presentation/details/views/similer_movies.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  bool _showTrailer = false;
  late WebViewController _webViewController;

  Future<void> _loadTrailer() async {
    final repo = context.read<MoviesRepo>();

    final key = await repo.getTrailerKey(widget.movie.id);

    if (!mounted) return;

    if (key == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("No trailer found")));
      return;
    }

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..loadRequest(Uri.parse('$youtubeUrl$key'));

    setState(() {
      _showTrailer = true;
    });
  }

  void _closeTrailer() {
    setState(() {
      _showTrailer = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
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
                  onPressed: () => Navigator.pop(context),
                  icon: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
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
                                Text("${widget.movie.voteAverage}"),
                                10.width,
                                const Icon(Icons.movie, size: 16),
                                4.width,
                                const Text("Movie"),
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
                        style: const TextStyle(height: 1.5),
                      ),

                      30.hight,

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _loadTrailer,
                          icon: const Icon(Icons.play_arrow),
                          label: const Text("Watch Trailer"),
                        ),
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
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      );
                    }

                    if (state.status == RequestStatus.failure) {
                      return Center(
                        child: Text(state.error ?? "Something went wrong"),
                      );
                    }

                    return SimilarMoviesShape(movies: state.similarMovies);
                  },
                ),
              ),
            ],
          ),

          if (_showTrailer)
            Positioned.fill(
              child: GestureDetector(
                onTap: _closeTrailer,
                child: Container(
                  color: Colors.black.withOpacity(0.85),
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.35,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          // Close button
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 24,
                              ),
                              onPressed: _closeTrailer,
                            ),
                          ),

                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                              child: WebViewWidget(
                                controller: _webViewController,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
