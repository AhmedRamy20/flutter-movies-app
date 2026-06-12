import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/busieness_logic/bloc/details/details_bloc.dart';
import 'package:movies_app/busieness_logic/bloc/details/details_state.dart';
import 'package:movies_app/core/confg/colors/app_colors.dart';
import 'package:movies_app/enums/req_status.dart';
import 'package:movies_app/presentation/details/widgets/similer_movies.dart';

class SimilarMoviesWidget extends StatelessWidget {
  const SimilarMoviesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        builder: (context, state) {
          if (state.status == RequestStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state.status == RequestStatus.failure) {
            return Center(child: Text(state.error ?? "Something went wrong"));
          }

          return SimilarMoviesShape(movies: state.similarMovies);
        },
      ),
    );
  }
}
