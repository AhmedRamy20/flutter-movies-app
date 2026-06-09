import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/app_router.dart';
import 'package:movies_app/busieness_logic/bloc/home/home_bloc.dart';
import 'package:movies_app/busieness_logic/bloc/home/home_event.dart';
import 'package:movies_app/busieness_logic/bloc/home/home_state.dart';
import 'package:movies_app/constents/routes.dart';
import 'package:movies_app/core/confg/colors/app_colors.dart';
import 'package:movies_app/enums/req_status.dart';
import 'package:movies_app/extension/sized_box.dart';
import 'package:movies_app/presentation/home/widgets/category_grid.dart';

Widget buildCategorySection(
  HomeState state,
  BuildContext context,
  TabController controller,
) {
  switch (state.categoryStatus) {
    case RequestStatus.loading:
      return const SizedBox(
        height: 300,
        child: Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      );

    case RequestStatus.failure:
      return Column(
        children: [
          Text(
            state.categoryError ?? "Failed to load category",
            style: const TextStyle(color: Colors.red),
          ),
          10.hight,
          ElevatedButton(
            onPressed: () {
              context.read<HomeBloc>().add(
                LoadCategoryMovies(state.selectedCategory),
              );
            },
            child: const Text("Retry"),
          ),
        ],
      );

    case RequestStatus.success:
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

          CategoryGrid(
            movies: state.categoryMovies,
            onTap: (movie) {
              Navigator.pushNamed(
                context,
                Routes.details,
                arguments: MovieDetailsArgs(movie: movie, heroSource: 'grid'),
              );
            },
          ),
        ],
      );

    case RequestStatus.initial:
      return const SizedBox.shrink();
  }
}
