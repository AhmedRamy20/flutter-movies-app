import 'package:dio/dio.dart';
import 'package:movies_app/constents/apis.dart';
import 'package:movies_app/data/model/movie_model.dart';

//? will do a good error handling later
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

  Future<List<Movie>> searchMovies(String query) async {
    try {
      final response = await dio.get(search, queryParameters: {'query': query});
      final movies = MoviesModel.fromJson(response.data);
      return movies.results;
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          throw Exception('No internet connection. Please try again.');

        case DioExceptionType.receiveTimeout:
          throw Exception('Receive timeout');

        case DioExceptionType.connectionError:
          throw Exception('No internet connection');

        default:
          throw Exception('Unexpected error');
      }
    }
  }

  Future<List<Movie>> fetchTrending() async {
    try {
      final response = await dio.get(trendingWeekly);
      if (response.statusCode == 200) {
        // print(response.data);
        final movies = MoviesModel.fromJson(response.data);
        return movies.results;
      }
      throw Exception('Request failed: ${response.statusCode}');
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          throw Exception('Connection timeout');

        case DioExceptionType.receiveTimeout:
          throw Exception('Receive timeout');

        case DioExceptionType.connectionError:
          throw Exception('No internet connection');

        case DioExceptionType.badResponse:
          throw Exception('Server error: ${e.response?.statusCode}');

        default:
          throw Exception('Unexpected error');
      }
    }
  }

  //? fetch popular movies
  Future<List<Movie>> fetchMovies(String endPoint) async {
    try {
      final response = await dio.get(endPoint);

      if (response.statusCode == 200) {
        final movies = MoviesModel.fromJson(response.data);

        return movies.results;
      }

      throw Exception('Request failed: ${response.statusCode}');
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          throw Exception('Connection timeout');

        case DioExceptionType.receiveTimeout:
          throw Exception('Receive timeout');

        case DioExceptionType.connectionError:
          throw Exception('No internet connection');

        case DioExceptionType.badResponse:
          throw Exception('Server error: ${e.response?.statusCode}');

        default:
          throw Exception('Unexpected error');
      }
    }
  }
}
