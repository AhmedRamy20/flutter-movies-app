import 'package:flutter/foundation.dart';
import 'package:movies_app/data/model/movie_model.dart';
import 'package:movies_app/presentation/views/home_view.dart';

@immutable
abstract class MovieState {}

class MoviesLoadingState extends MovieState {}

class MoviesLoadedState extends MovieState {
  final List<Movie>? trendingMovies;
  final List<Movie>? categoryMoviesList;
  final MovieCategory? selectedCategory;
  final List<Movie>? searchResults;
  final bool isSearching;

  MoviesLoadedState({
    required this.trendingMovies,
    required this.categoryMoviesList,
    required this.selectedCategory,
    this.searchResults = const [],
    this.isSearching = false,
  });
  MoviesLoadedState copyWith({
    List<Movie>? trendingMovies,
    List<Movie>? categoryMoviesList,
    List<Movie>? searchResults,
    MovieCategory? selectedCategory,
    bool? isSearching,
  }) {
    return MoviesLoadedState(
      trendingMovies: trendingMovies ?? this.trendingMovies,
      categoryMoviesList: categoryMoviesList ?? this.categoryMoviesList,
      searchResults: searchResults ?? this.searchResults,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isSearching: isSearching ?? this.isSearching,
    );
  }
}

class MoviesErrorState extends MovieState {
  final String error;

  MoviesErrorState({required this.error});
}
