import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/busieness_logic/bloc/details/details_bloc.dart';
import 'package:movies_app/busieness_logic/bloc/details/details_event.dart';

import 'package:movies_app/constents/routes.dart';
import 'package:movies_app/data/model/movie_model.dart';
import 'package:movies_app/data/repository/movies_repo.dart';
import 'package:movies_app/presentation/home/views/bottom_nav.dart';
import 'package:movies_app/presentation/home/views/movie_details.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const BottomNavEntry());

      case Routes.details:
        final args = settings.arguments as MovieDetailsArgs;

        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (_) => MovieDetailsBloc(
                RepositoryProvider.of<MoviesRepo>(context),
                args.movie,
              )..add(LoadSimilarMoviesEvent(args.movie.id)),
              child: MoviesDetailsView(
                movie: args.movie,
                heroSource: args.heroSource,
              ),
            );
          },
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("oops route not found :(")),
          ),
        );
    }
  }
}

class MovieDetailsArgs {
  final Movie movie;
  final String heroSource;

  MovieDetailsArgs({required this.movie, required this.heroSource});
}
