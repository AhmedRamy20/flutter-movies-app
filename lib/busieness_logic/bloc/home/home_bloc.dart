import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:movies_app/busieness_logic/bloc/home/home_event.dart';
import 'package:movies_app/busieness_logic/bloc/home/home_state.dart';
import 'package:movies_app/data/model/movie_hive_model.dart';
import 'package:movies_app/data/repository/movies_repo.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MoviesRepo repository;
  final box = Hive.box<MovieHiveModel>('favorites');
  HomeBloc(this.repository) : super(const HomeState()) {
    on<LoadTrendingMovies>(_loadTrending);
    on<LoadCategoryMovies>(_loadCategory);
    on<ToggleFavoriteMovieEvent>(_toggleFavorite);
    on<LoadFavoritesEvent>(_loadFavorites);
    on<SyncFavoritesFromHive>(_syncFavorites);
    add(LoadFavoritesEvent());
  }

  Future<void> _syncFavorites(
    SyncFavoritesFromHive event,
    Emitter<HomeState> emit,
  ) async {
    final ids = box.values.map((e) => e.id).toSet();

    emit(state.copyWith(favoriteIds: ids));
  }

  Future<void> _loadTrending(
    LoadTrendingMovies event,
    Emitter<HomeState> emit,
  ) async {
    final movies = await repository.getTrending();
    emit(state.copyWith(trendingMovies: movies));
  }

  Future<void> _loadCategory(
    LoadCategoryMovies event,
    Emitter<HomeState> emit,
  ) async {
    final movies = await repository.getMovieBasedOnCategory(event.category);

    emit(
      state.copyWith(categoryMovies: movies, selectedCategory: event.category),
    );
  }

  void _toggleFavorite(
    ToggleFavoriteMovieEvent event,
    Emitter<HomeState> emit,
  ) {
    final box = Hive.box<MovieHiveModel>('favorites');
    final movie = event.movie;

    final isFav = box.containsKey(movie.id);

    if (isFav) {
      box.delete(movie.id);
    } else {
      box.put(
        movie.id,
        MovieHiveModel(
          id: movie.id,
          title: movie.title,
          posterPath: movie.posterPath,
        ),
      );
    }

    // rebuild UI state from Hive (NOT from old state)
    final updatedIds = box.keys.cast<int>().toSet();

    emit(state.copyWith(favoriteIds: updatedIds));
  }

  Future<void> _loadFavorites(
    LoadFavoritesEvent event,
    Emitter<HomeState> emit,
  ) async {
    final box = Hive.box<MovieHiveModel>('favorites');

    final ids = box.keys.cast<int>().toSet();

    emit(state.copyWith(favoriteIds: ids));
  }
}
