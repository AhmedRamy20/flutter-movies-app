import 'package:equatable/equatable.dart';
import 'package:movies_app/data/model/movie_model.dart';
import 'package:movies_app/enums/category.dart';
import 'package:movies_app/enums/req_status.dart';

class HomeState extends Equatable {
  final List<Movie> trendingMovies;
  final List<Movie> categoryMovies;
  final MovieCategory selectedCategory;
  final Set<int> favoriteIds;
  final RequestStatus trendingStatus;
  final RequestStatus categoryStatus;
  final String? trendingerror;
  final String? categoryError;
  const HomeState({
    this.trendingMovies = const [],
    this.categoryMovies = const [],
    this.selectedCategory = MovieCategory.nowPlaying,
    this.favoriteIds = const {},
    this.trendingStatus = RequestStatus.initial,
    this.categoryStatus = RequestStatus.initial,
    this.trendingerror,
    this.categoryError,
  });

  HomeState copyWith({
    List<Movie>? trendingMovies,
    List<Movie>? categoryMovies,
    MovieCategory? selectedCategory,
    Set<int>? favoriteIds,
    RequestStatus? trendingStatus,
    RequestStatus? categoryStatus,
    String? trendingerror,
    String? categoryError,
  }) {
    return HomeState(
      trendingMovies: trendingMovies ?? this.trendingMovies,
      categoryMovies: categoryMovies ?? this.categoryMovies,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      favoriteIds: favoriteIds ?? this.favoriteIds,
      trendingStatus: trendingStatus ?? this.trendingStatus,
      categoryStatus: categoryStatus ?? this.categoryStatus,
      trendingerror: trendingerror,
      categoryError: categoryError,
    );
  }

  @override
  List<Object?> get props => [
    trendingMovies,
    categoryMovies,
    selectedCategory,
    favoriteIds,
    trendingStatus,
    trendingerror,
    categoryStatus,
    categoryError,
  ];
}
