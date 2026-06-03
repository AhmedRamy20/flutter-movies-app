import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/busieness_logic/bloc/movie_bloc.dart';
import 'package:movies_app/data/repository/movies_repo.dart';
import 'package:movies_app/data/web_service/web_service.dart';
import 'package:movies_app/presentation/views/home_view.dart';

void main() {
  runApp(const MoviesApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => MoviesRepo(webService: WebService()),
      child: BlocProvider(
        create: (context) => MovieBloc(moviesRepo: context.read<MoviesRepo>()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const HomeView(),
        ),
      ),
    );
  }
}
