import 'package:movies_app/data/model/movie_model.dart';

String heroTag(Movie movie, String source) {
  return "movie_${movie.id}_$source";
}
