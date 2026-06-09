//? details

import 'package:equatable/equatable.dart';
import 'package:movies_app/data/model/movie_model.dart';
import 'package:movies_app/enums/req_status.dart';

class MovieDetailsState extends Equatable {
  final Movie movie;
  final List<Movie> similarMovies;
  final RequestStatus status;
  final String? error;

  const MovieDetailsState({
    required this.movie,
    this.similarMovies = const [],
    this.status = RequestStatus.initial,
    this.error,
  });

  MovieDetailsState copyWith({
    Movie? movie,
    List<Movie>? similarMovies,
    RequestStatus? status,
    String? error,
  }) {
    return MovieDetailsState(
      movie: movie ?? this.movie,
      similarMovies: similarMovies ?? this.similarMovies,
      status: status ?? this.status,
      error: error,
    );
  }

  @override
  List<Object?> get props => [movie, similarMovies, status, error];
}
