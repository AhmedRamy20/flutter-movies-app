import 'package:movies_app/core/constants/apis.dart';
import 'package:movies_app/data/model/movie_model.dart';
import 'package:movies_app/data/web_service/web_service.dart';
import 'package:movies_app/core/enums/category.dart';

class MoviesRepo {
  final WebService webService;
  MoviesRepo({required this.webService});

  Future<List<Movie>> searchMovies(String query) async {
    return await webService.searchMovies(query);
  }

  Future<List<Movie>> getRecommendedMovies(int movieId) async {
    return webService.getRecommendedMovies(movieId);
  }

  //? trending movies
  Future<List<Movie>> getTrending() {
    return webService.fetchTrending();
  }

  //? movies based on selected category
  Future<MoviesModel> getMovieBasedOnCategory(
    MovieCategory category, {
    int page = 1,
  }) async {
    switch (category) {
      case MovieCategory.nowPlaying:
        return webService.fetchMovies(nowPlaying, page: page);
      case MovieCategory.popular:
        return webService.fetchMovies(popular, page: page);
      case MovieCategory.topRated:
        return webService.fetchMovies(topRated, page: page);
      case MovieCategory.upcoming:
        return webService.fetchMovies(upcoming, page: page);
    }
  }

  //trailer
  Future<String?> getTrailerKey(int movieId) {
    return webService.getTrailerKey(movieId);
  }
}
