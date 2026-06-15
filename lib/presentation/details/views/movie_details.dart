import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/constants/apis.dart';
import 'package:movies_app/core/confg/colors/app_colors.dart';
import 'package:movies_app/data/model/movie_model.dart';
import 'package:movies_app/data/repository/movies_repo.dart';
import 'package:movies_app/core/extension/is_dark.dart';
import 'package:movies_app/core/extension/sized_box.dart';
import 'package:movies_app/helpers/image_helper.dart';
import 'package:movies_app/presentation/details/widgets/fav_button_widget.dart';
import 'package:movies_app/presentation/details/widgets/movie_details_content.dart';
import 'package:movies_app/presentation/details/widgets/on_top_trailer.dart';
import 'package:movies_app/presentation/details/widgets/similir_movies_widget.dart';
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
                actions: [FavoriteButtonWidget(movie: widget.movie)],
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

              MovieDetailsContentWidget(
                movie: widget.movie,
                onLoadTrailer: _loadTrailer,
              ),

              SimilarMoviesWidget(),
            ],
          ),

          if (_showTrailer)
            OnTopTrailerWidget(
              controller: _webViewController,
              onClose: _closeTrailer,
            ),
        ],
      ),
    );
  }
}
