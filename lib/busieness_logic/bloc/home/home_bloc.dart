import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/busieness_logic/bloc/home/home_event.dart';
import 'package:movies_app/busieness_logic/bloc/home/home_state.dart';
import 'package:movies_app/data/repository/movies_repo.dart';
import 'package:movies_app/core/enums/req_status.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MoviesRepo repository;
  HomeBloc(this.repository) : super(const HomeState()) {
    on<LoadTrendingMovies>(_loadTrending);
    on<LoadCategoryMovies>(_loadCategory);
    on<LoadMoreMovies>(_loadMoreMovies);
  }

  Future<void> _loadTrending(
    LoadTrendingMovies event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        trendingStatus: RequestStatus.loading,
        trendingerror: null,
      ),
    );

    try {
      final movies = await repository.getTrending();

      emit(
        state.copyWith(
          trendingMovies: movies,
          trendingStatus: RequestStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          trendingStatus: RequestStatus.failure,
          trendingerror: e.toString(),
        ),
      );
    }
  }

  Future<void> _loadMoreMovies(
    LoadMoreMovies event,
    Emitter<HomeState> emit,
  ) async {
    if (state.isLoadingMore) return;
    if (state.currentPage >= state.totalPages) return;

    emit(state.copyWith(isLoadingMore: true));

    emit(state.copyWith(isLoadingMore: true));

    try {
      final response = await repository.getMovieBasedOnCategory(
        state.selectedCategory,
        page: state.currentPage + 1,
      );

      emit(
        state.copyWith(
          categoryMovies: [...state.categoryMovies, ...response.results],
          currentPage: response.page,
          totalPages: response.totalPages,
          isLoadingMore: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoadingMore: false));
    }
  }

  Future<void> _loadCategory(
    LoadCategoryMovies event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        categoryStatus: RequestStatus.loading,
        categoryError: null,
        currentPage: 1,
        totalPages: 1,
        categoryMovies: [],
      ),
    );

    try {
      final response = await repository.getMovieBasedOnCategory(
        event.category,
        page: 1,
      );

      emit(
        state.copyWith(
          categoryMovies: response.results,
          categoryStatus: RequestStatus.success,
          selectedCategory: event.category,
          currentPage: response.page,
          totalPages: response.totalPages,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          categoryStatus: RequestStatus.failure,
          categoryError: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }
}
