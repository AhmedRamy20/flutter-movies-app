import 'package:flutter/foundation.dart';
import 'package:movies_app/enums/category.dart';

@immutable
abstract class MovieEvent {}

class LoadTrendingMovies extends MovieEvent {}

class GetMoviesBasedOnCategoryEvent extends MovieEvent {
  final MovieCategory category;

  GetMoviesBasedOnCategoryEvent(this.category);
}

class SearchMoviesEvent extends MovieEvent {
  final String serchedQuery;

  SearchMoviesEvent(this.serchedQuery);
}

class ClearSearchEvent extends MovieEvent {}
