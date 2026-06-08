import 'package:equatable/equatable.dart';
import 'package:movies_app/data/model/movie_model.dart';
import 'package:movies_app/enums/category.dart';

class HomeState extends Equatable {
  final List<Movie> trendingMovies;
  final List<Movie> categoryMovies;
  final MovieCategory selectedCategory;
  final Set<int> favoriteIds;

  const HomeState({
    this.trendingMovies = const [],
    this.categoryMovies = const [],
    this.selectedCategory = MovieCategory.nowPlaying,
    this.favoriteIds = const {},
  });

  HomeState copyWith({
    List<Movie>? trendingMovies,
    List<Movie>? categoryMovies,
    MovieCategory? selectedCategory,
    Set<int>? favoriteIds,
  }) {
    return HomeState(
      trendingMovies: trendingMovies ?? this.trendingMovies,
      categoryMovies: categoryMovies ?? this.categoryMovies,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      favoriteIds: favoriteIds ?? this.favoriteIds,
    );
  }

  @override
  List<Object?> get props => [
    trendingMovies,
    categoryMovies,
    selectedCategory,
    favoriteIds,
  ];
}
