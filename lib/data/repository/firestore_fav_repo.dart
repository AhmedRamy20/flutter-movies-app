import 'package:movies_app/data/firestore_service/favorites_service.dart';
import 'package:movies_app/data/model/movie_model.dart';

class FireStoreFavoritesRepo {
  final FavoritesService service;

  FireStoreFavoritesRepo(this.service);

  Future<void> add(Movie movie) => service.addFavorite(movie);

  Future<void> remove(int id) => service.removeFavorite(id);

  Future<bool> isFavorite(int id) => service.isFavorite(id);

  Stream<List<Movie>> watch() => service.watchFavorites();
}
