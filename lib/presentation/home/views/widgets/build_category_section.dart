import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/app_router.dart';
import 'package:movies_app/busieness_logic/bloc/home/home_bloc.dart';
import 'package:movies_app/busieness_logic/bloc/home/home_event.dart';
import 'package:movies_app/busieness_logic/bloc/home/home_state.dart';
import 'package:movies_app/core/confg/colors/app_colors.dart';
import 'package:movies_app/core/confg/widgets/category_shimmer.dart';
import 'package:movies_app/core/constants/routes.dart';
import 'package:movies_app/enums/req_status.dart';
import 'package:movies_app/presentation/home/widgets/category_grid.dart';

Widget buildCategorySection(
  HomeState state,
  BuildContext context,
  TabController controller,
) {
  return Column(
    children: [
      TabBar(
        controller: controller,
        labelColor: AppColors.primary,
        indicatorColor: AppColors.primary,
        tabs: const [
          Tab(text: "Now Playing"),
          Tab(text: "Popular"),
          Tab(text: "Top Rated"),
          Tab(text: "Upcoming"),
        ],
      ),
      const SizedBox(height: 8),
      Expanded(
        child: Builder(
          builder: (context) {
            if (state.categoryStatus == RequestStatus.loading &&
                state.categoryMovies.isEmpty) {
              return const CategoryGridShimmer();
            } else if (state.categoryStatus == RequestStatus.failure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.categoryError ?? "Failed to load category",
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        context.read<HomeBloc>().add(
                          LoadCategoryMovies(state.selectedCategory),
                        );
                      },
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              );
            } else {
              return CategoryGrid(
                movies: state.categoryMovies,
                isLoadingMore: state.isLoadingMore,
                onTap: (movie) {
                  Navigator.pushNamed(
                    context,
                    Routes.details,
                    arguments: MovieDetailsArgs(
                      movie: movie,
                      heroSource: 'grid',
                    ),
                  );
                },
                onLoadMore: () {
                  if (!state.isLoadingMore &&
                      state.currentPage < state.totalPages) {
                    context.read<HomeBloc>().add(LoadMoreMovies());
                  }
                },
              );
            }
          },
        ),
      ),
    ],
  );
}
