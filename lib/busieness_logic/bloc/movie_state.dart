import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movies_app/data/model/movie_model.dart';
import 'package:movies_app/enums/category.dart';

@immutable
abstract class MovieState {}

// while entering the home view
class MoviesLoadingState extends MovieState {}

class MoviesLoadedState extends MovieState with EquatableMixin {
  final List<Movie> trendingMovies;
  final List<Movie> categoryMoviesList;
  final MovieCategory selectedCategory;
  final List<Movie> searchResults;
  final bool isSearching;
  final String? errorMessage;

  MoviesLoadedState({
    required this.trendingMovies,
    required this.categoryMoviesList,
    required this.selectedCategory,
    this.searchResults = const [],
    this.isSearching = false,
    this.errorMessage,
  });

  MoviesLoadedState copyWith({
    List<Movie>? trendingMovies,
    List<Movie>? categoryMoviesList,
    List<Movie>? searchResults,
    MovieCategory? selectedCategory,
    bool? isSearching,
    String? errorMessage,
  }) {
    return MoviesLoadedState(
      trendingMovies: trendingMovies ?? this.trendingMovies,
      categoryMoviesList: categoryMoviesList ?? this.categoryMoviesList,
      searchResults: searchResults ?? this.searchResults,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isSearching: isSearching ?? this.isSearching,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    trendingMovies,
    categoryMoviesList,
    selectedCategory,
    searchResults,
    isSearching,
    errorMessage,
  ];
}

class MoviesErrorState extends MovieState {
  final String error;

  MoviesErrorState({required this.error});
}
