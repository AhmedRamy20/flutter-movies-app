import 'package:movies_app/data/model/movie_model.dart';
import 'package:movies_app/enums/category.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class LoadTrendingMovies extends HomeEvent {}

class LoadCategoryMovies extends HomeEvent {
  final MovieCategory category;
  LoadCategoryMovies(this.category);
}

class ToggleFavoriteMovieEvent extends HomeEvent {
  final Movie movie;
  ToggleFavoriteMovieEvent(this.movie);
}

class LoadFavoritesEvent extends HomeEvent {}

class SyncFavoritesFromHive extends HomeEvent {}

// from pagination
class LoadMoreMovies extends HomeEvent {}
