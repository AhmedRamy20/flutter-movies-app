import 'package:flutter/material.dart';

class SafeMovieImage extends StatelessWidget {
  final String? path;
  final double? width;
  final String? title;

  const SafeMovieImage({super.key, required this.path, this.width, this.title});

  @override
  Widget build(BuildContext context) {
    if (path == null || path!.isEmpty) {
      return _fallbackWidget();
    }

    return Image.network(
      "https://image.tmdb.org/t/p/w500$path",
      width: width,
      fit: BoxFit.cover,

      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;

        return SizedBox(
          width: width,
          child: Image.asset("assets/images/loading.gif", fit: BoxFit.cover),
        );
      },

      errorBuilder: (_, _, _) {
        return _fallbackWidget();
      },
    );
  }

  Widget _fallbackWidget() {
    return Container(
      width: width,
      color: Colors.grey.shade300,
      alignment: Alignment.center,
      child: const Icon(Icons.movie, size: 50),
    );
  }
}
