//? search
abstract class SearchEvent {}

class SearchMoviesEvent extends SearchEvent {
  final String query;
  SearchMoviesEvent(this.query);
}

class ClearSearchEvent extends SearchEvent {}
