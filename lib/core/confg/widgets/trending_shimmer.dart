import 'package:flutter/material.dart';
import 'package:movies_app/core/extension/is_dark.dart';
import 'package:shimmer/shimmer.dart';

class TrendingMoviesShimmer extends StatelessWidget {
  const TrendingMoviesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Shimmer.fromColors(
              baseColor: context.isDark
                  ? Colors.grey.shade800
                  : Colors.grey.shade300,
              highlightColor: context.isDark
                  ? Colors.grey.shade700
                  : Colors.grey.shade100,
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
