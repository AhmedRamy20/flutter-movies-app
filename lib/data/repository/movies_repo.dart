import 'package:movies_app/constents/apis.dart';
import 'package:movies_app/data/model/movie_model.dart';
import 'package:movies_app/data/web_service/web_service.dart';
import 'package:movies_app/enums/category.dart';

class MoviesRepo {
  final WebService webService;
  MoviesRepo({required this.webService});

  Future<List<Movie>> searchMovies(String query) async {
    return await webService.searchMovies(query);
  }

  //? trending movies
  Future<List<Movie>> getTrending() {
    return webService.fetchTrending();
  }

  //? movies based on selected category
  Future<List<Movie>> getMovieBasedOnCategory(MovieCategory category) async {
    switch (category) {
      case MovieCategory.nowPlaying:
        return webService.fetchMovies(nowPlaying);
      case MovieCategory.popular:
        return webService.fetchMovies(popular);
      case MovieCategory.topRated:
        return webService.fetchMovies(topRated);
      case MovieCategory.upcoming:
        return webService.fetchMovies(upcoming);
    }
  }
}
