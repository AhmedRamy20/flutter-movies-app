import 'package:dio/dio.dart';

String mapDioError(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      return 'Connection timeout';

    case DioExceptionType.receiveTimeout:
      return 'Server took too long to respond';

    case DioExceptionType.connectionError:
      return 'No internet connection';

    default:
      return 'Something went wrong';
  }
}
