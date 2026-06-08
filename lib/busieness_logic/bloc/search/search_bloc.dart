//? search

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/busieness_logic/bloc/search/search_event.dart';
import 'package:movies_app/busieness_logic/bloc/search/search_state.dart';
import 'package:movies_app/data/repository/movies_repo.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final MoviesRepo repository;

  SearchBloc(this.repository) : super(const SearchState()) {
    on<SearchMoviesEvent>(_search);
    on<ClearSearchEvent>(_clear);
  }

  Future<void> _search(
    SearchMoviesEvent event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.isEmpty) return;

    final results = await repository.searchMovies(event.query);

    emit(state.copyWith(results: results, isSearching: true));
  }

  void _clear(ClearSearchEvent event, Emitter<SearchState> emit) {
    emit(const SearchState());
  }
}
