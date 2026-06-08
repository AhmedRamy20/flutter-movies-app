//? search
import 'package:equatable/equatable.dart';
import 'package:movies_app/data/model/movie_model.dart';

class SearchState extends Equatable {
  final List<Movie> results;
  final bool isSearching;

  const SearchState({this.results = const [], this.isSearching = false});

  SearchState copyWith({List<Movie>? results, bool? isSearching}) {
    return SearchState(
      results: results ?? this.results,
      isSearching: isSearching ?? this.isSearching,
    );
  }

  @override
  List<Object?> get props => [results, isSearching];
}
