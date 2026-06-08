import 'package:movies_app/data/model/movie_model.dart';
import 'package:movies_app/data/model/movie_hive_model.dart';

extension MovieHiveMapper on MovieHiveModel {
  Movie toMovie() {
    return Movie(
      id: id,
      title: title,
      posterPath: posterPath ?? '',
      overview: overview ?? '',
      voteAverage: voteAverage ?? 0,
      backdropPath: backdropPath ?? '',
    );
  }
}
