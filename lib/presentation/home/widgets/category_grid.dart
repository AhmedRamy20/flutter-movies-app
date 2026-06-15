import 'package:flutter/material.dart';
import 'package:movies_app/data/model/movie_model.dart';
import 'package:movies_app/presentation/home/widgets/movie_card_widget.dart';

class CategoryGrid extends StatefulWidget {
  final List movies;
  final Function(Movie) onTap;
  final VoidCallback onLoadMore;
  final bool isLoadingMore;
  const CategoryGrid({
    super.key,
    required this.movies,
    required this.onTap,
    required this.onLoadMore,
    required this.isLoadingMore,
  });

  @override
  State<CategoryGrid> createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    // load more when 80% scrolled
    if (currentScroll >= maxScroll * 0.8) {
      widget.onLoadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(12),
      itemCount: widget.movies.length + (widget.isLoadingMore ? 1 : 0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        if (index == widget.movies.length) {
          return const Padding(
            padding: EdgeInsets.all(12),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final movie = widget.movies[index];

        return GestureDetector(
          onTap: () => widget.onTap(movie),
          child: MovieCard(
            movie: movie,
            heroTag: "movie_${movie.id}_grid",
            useHero: true,
            showTitle: true,
          ),
        );
      },
    );
  }
}
