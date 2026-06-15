import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/app_router.dart';
import 'package:movies_app/busieness_logic/bloc/home/home_bloc.dart';
import 'package:movies_app/busieness_logic/bloc/home/home_event.dart';
import 'package:movies_app/busieness_logic/bloc/home/home_state.dart';
import 'package:movies_app/core/confg/widgets/trending_shimmer.dart';
import 'package:movies_app/core/constants/routes.dart';
import 'package:movies_app/core/enums/req_status.dart';
import 'package:movies_app/core/extension/sized_box.dart';
import 'package:movies_app/presentation/home/widgets/trending_widget.dart';

Widget buildTrendingSection(HomeState state, BuildContext context) {
  switch (state.trendingStatus) {
    case RequestStatus.loading:
      return TrendingMoviesShimmer();

    case RequestStatus.failure:
      return SizedBox(
        height: 220,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              state.trendingerror ?? "Something went wrong",
              style: const TextStyle(color: Colors.red),
            ),
            10.hight,
            ElevatedButton(
              onPressed: () {
                context.read<HomeBloc>().add(LoadTrendingMovies());
              },
              child: const Text("Retry"),
            ),
          ],
        ),
      );

    case RequestStatus.success:
      return TrendingMoviesSection(
        movies: state.trendingMovies,
        onTap: (movie) {
          Navigator.pushNamed(
            context,
            Routes.details,
            arguments: MovieDetailsArgs(movie: movie, heroSource: 'trending'),
          );
        },
      );

    case RequestStatus.initial:
      return const SizedBox.shrink();
  }
}
