import 'package:hive/hive.dart';
import 'package:movies_app/data/model/movie_hive_model.dart';
import 'package:movies_app/data/model/movie_model.dart';

class FavoritesRepo {
  final Box<MovieHiveModel> box = Hive.box<MovieHiveModel>('favorites');

  Set<int> getFavorites() {
    return box.values.map((e) => e.id).toSet();
  }

  void toggle(Movie movie) {
    final box = Hive.box<MovieHiveModel>('favorites');

    final key = box.keys.firstWhere(
      (k) => box.get(k)!.id == movie.id,
      orElse: () => null,
    );

    if (key != null) {
      box.delete(key);
    } else {
      box.add(
        MovieHiveModel(
          id: movie.id,
          title: movie.title,
          posterPath: movie.posterPath,
        ),
      );
    }
  }

  List<MovieHiveModel> getAllFavorites() {
    return box.values.toList();
  }
}
