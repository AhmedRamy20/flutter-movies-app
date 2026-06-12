import 'package:flutter/material.dart';
import 'package:movies_app/data/model/movie_model.dart';
import 'package:movies_app/extension/sized_box.dart';

class MovieDetailsContentWidget extends StatelessWidget {
  final Movie movie;
  final VoidCallback onLoadTrailer;

  const MovieDetailsContentWidget({
    super.key,
    required this.movie,
    required this.onLoadTrailer,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Overview", style: Theme.of(context).textTheme.titleLarge),
            10.hight,
            Text(movie.overview, style: const TextStyle(height: 1.5)),
            30.hight,
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onLoadTrailer,
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
    );
  }
}
