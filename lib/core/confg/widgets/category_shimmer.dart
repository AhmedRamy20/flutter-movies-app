import 'package:flutter/material.dart';
import 'package:movies_app/extension/is_dark.dart';
import 'package:shimmer/shimmer.dart';

class CategoryGridShimmer extends StatelessWidget {
  const CategoryGridShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: 9,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.65,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: context.isDark
              ? Colors.grey.shade800
              : Colors.grey.shade300,
          highlightColor: context.isDark
              ? Colors.grey.shade700
              : Colors.grey.shade100,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(height: 12, width: 60, color: Colors.white),
            ],
          ),
        );
      },
    );
  }
}
