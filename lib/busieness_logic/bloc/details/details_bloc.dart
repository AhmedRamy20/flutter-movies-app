//? details

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/busieness_logic/bloc/details/details_event.dart';
import 'package:movies_app/busieness_logic/bloc/details/details_state.dart';
import 'package:movies_app/data/model/movie_model.dart';
import 'package:movies_app/data/repository/movies_repo.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final MoviesRepo repository;

  MovieDetailsBloc(this.repository, Movie movie)
    : super(MovieDetailsState(movie: movie)) {
    on<LoadSimilarMoviesEvent>(_loadSimilar);
  }

  Future<void> _loadSimilar(
    LoadSimilarMoviesEvent event,
    Emitter<MovieDetailsState> emit,
  ) async {
    final similar = await repository.getRecommendedMovies(event.movieId);

    emit(state.copyWith(similarMovies: similar));
  }
}
