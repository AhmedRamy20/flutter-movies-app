import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/busieness_logic/bloc/connection/connection_cubit.dart';
import 'package:movies_app/core/constants/apis.dart';

class SafeMovieImage extends StatelessWidget {
  final String? path;
  final double? width;
  final String? title;

  const SafeMovieImage({super.key, required this.path, this.width, this.title});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectionCubit, bool>(
      builder: (context, hasInternet) {
        if (!hasInternet || path == null || path!.isEmpty) {
          return _fallbackWidget();
        }

        return Image.network(
          "$movieImageUrl$path",
          width: width,
          height: width,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => _fallbackWidget(),
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;

            return SizedBox(
              width: width,
              child: Image.asset(
                "assets/images/loading.gif",
                fit: BoxFit.contain,
                width: 30,
                height: 30,
              ),
            );
          },
        );
      },
    );
  }

  Widget _fallbackWidget() {
    return Container(
      width: width,
      color: Colors.grey.shade300,
      alignment: Alignment.center,
      child: const Icon(Icons.image_not_supported, size: 50),
    );
  }
}
