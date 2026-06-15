import 'package:dio/dio.dart';
import 'package:movies_app/core/constants/apis.dart';
import 'package:movies_app/data/model/movie_model.dart';
import 'package:movies_app/core/exceptions/dio_exceptions.dart';

class WebService {
  late Dio dio;

  WebService() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      queryParameters: {'api_key': key},
    );
    dio = Dio(options);
  }

  Future<List<Movie>> getRecommendedMovies(int movieId) async {
    try {
      final response = await dio.get("/movie/$movieId/similar");

      final data = response.data['results'] as List;

      return data.map((e) => Movie.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(mapDioError(e));
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    try {
      final response = await dio.get(search, queryParameters: {'query': query});
      final movies = MoviesModel.fromJson(response.data);
      return movies.results;
    } on DioException catch (e) {
      throw Exception(mapDioError(e));
    }
  }

  Future<List<Movie>> fetchTrending() async {
    try {
      final response = await dio.get(trendingWeekly);

      final movies = MoviesModel.fromJson(response.data);
      return movies.results;
    } on DioException catch (e) {
      throw Exception(mapDioError(e));
    }
  }

  //? fetch based on the categ
  Future<MoviesModel> fetchMovies(String endPoint, {int page = 1}) async {
    try {
      final response = await dio.get(endPoint, queryParameters: {'page': page});

      return MoviesModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(mapDioError(e));
    }
  }

  //trailer
  Future<String?> getTrailerKey(int movieId) async {
    try {
      final response = await dio.get("/movie/$movieId/videos");

      final data = response.data['results'] as List;

      final trailers = data.where((video) {
        return video['site'] == 'YouTube' && video['type'] == 'Trailer';
      }).toList();

      if (trailers.isEmpty) return null;

      return trailers.first['key'];
    } on DioException catch (e) {
      throw Exception(mapDioError(e));
    }
  }
}
