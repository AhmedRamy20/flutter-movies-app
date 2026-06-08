//? Details
abstract class MovieDetailsEvent {}

class LoadSimilarMoviesEvent extends MovieDetailsEvent {
  final int movieId;
  LoadSimilarMoviesEvent(this.movieId);
}
