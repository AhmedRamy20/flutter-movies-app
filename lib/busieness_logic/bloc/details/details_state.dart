//? details

import 'package:equatable/equatable.dart';
import 'package:movies_app/data/model/movie_model.dart';

class MovieDetailsState extends Equatable {
  final Movie movie;
  final List<Movie> similarMovies;

  const MovieDetailsState({required this.movie, this.similarMovies = const []});

  MovieDetailsState copyWith({Movie? movie, List<Movie>? similarMovies}) {
    return MovieDetailsState(
      movie: movie ?? this.movie,
      similarMovies: similarMovies ?? this.similarMovies,
    );
  }

  @override
  List<Object?> get props => [movie, similarMovies];
}
