import 'package:flutter/material.dart';
import 'package:movies_app/app_router.dart';
import 'package:movies_app/constents/routes.dart';
import 'package:movies_app/helpers/image_helper.dart';

class SimilarMoviesShape extends StatefulWidget {
  final List movies;

  const SimilarMoviesShape({super.key, required this.movies});

  @override
  State<SimilarMoviesShape> createState() => _SimilarMoviesShapeState();
}

class _SimilarMoviesShapeState extends State<SimilarMoviesShape> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.6);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: PageView.builder(
        controller: _controller,
        padEnds: false,
        physics: const BouncingScrollPhysics(),
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          final movie = widget.movies[index];

          // final poster = movie.posterPath;
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              double scale = 1.0;

              if (_controller.position.haveDimensions) {
                scale = (_controller.page! - index).abs();
                scale = (1 - (scale * 0.25)).clamp(0.85, 1.0);
              }

              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.details,
                    arguments: MovieDetailsArgs(
                      movie: movie,
                      heroSource: 'similar',
                    ),
                  );
                },
                child: Transform.scale(
                  scale: scale,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          SafeMovieImage(path: movie.posterPath),

                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.8),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),

                          Positioned(
                            bottom: 10,
                            left: 10,
                            right: 10,
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
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
