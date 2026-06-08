import 'package:hive/hive.dart';

part 'movie_hive_model.g.dart';

@HiveType(typeId: 0)
class MovieHiveModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String? posterPath;

  @HiveField(3)
  final String? overview;

  @HiveField(4)
  final String? backdropPath;

  @HiveField(5)
  final double? voteAverage;

  MovieHiveModel({
    required this.id,
    required this.title,
    this.posterPath,
    this.overview,
    this.backdropPath,
    this.voteAverage,
  });
}
