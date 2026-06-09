import 'package:bloc/bloc.dart';
import 'package:movies_app/data/model/movie_model.dart';
import 'package:movies_app/data/repository/firestore_fav_repo.dart';

class FavoritesCubit extends Cubit<Set<int>> {
  final FireStoreFavoritesRepo repo;

  FavoritesCubit(this.repo) : super({});

  Future<void> loadFavorites() async {
    final movies = await repo.service.getFavorites();
    emit(movies.map((m) => m.id).toSet());
  }

  Future<void> toggleFavorite(Movie movie) async {
    final current = Set<int>.from(state);

    if (current.contains(movie.id)) {
      await repo.remove(movie.id);
      current.remove(movie.id);
    } else {
      await repo.add(movie);
      current.add(movie.id);
    }

    emit(current);
  }

  bool isFav(int id) => state.contains(id);
}
