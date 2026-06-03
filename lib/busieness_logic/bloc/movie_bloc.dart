import 'package:bloc/bloc.dart';
import 'package:movies_app/busieness_logic/bloc/movie_event.dart';
import 'package:movies_app/busieness_logic/bloc/movie_state.dart';
import 'package:movies_app/data/repository/movies_repo.dart';
import 'package:movies_app/presentation/views/home_view.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MoviesRepo moviesRepo;
  MovieBloc({required this.moviesRepo}) : super(MoviesLoadingState()) {
    //! searched
    on<SearchMoviesEvent>((event, emit) async {
      if (event.serchedQuery.isEmpty) {
        add(LoadTrendingMovies());
        return;
      }

      try {
        final result = await moviesRepo.searchMovies(event.serchedQuery);
        emit(
          MoviesLoadedState(
            trendingMovies: [],
            categoryMoviesList: [],
            selectedCategory: null,
            searchResults: result,
            isSearching: true,
          ),
        );
      } catch (e) {
        emit(MoviesErrorState(error: e.toString()));
      }
    });

    on<ClearSearchEvent>((event, emit) async {
      emit(MoviesLoadingState());

      try {
        final trending = await moviesRepo.getTrending();
        final category = await moviesRepo.getMovieBasedOnCategory(
          MovieCategory.nowPlaying,
        );

        emit(
          MoviesLoadedState(
            trendingMovies: trending,
            categoryMoviesList: category,
            selectedCategory: MovieCategory.nowPlaying,
            searchResults: null,
            isSearching: false,
          ),
        );
      } catch (e) {
        emit(MoviesErrorState(error: e.toString()));
      }
    });

    //! trending
    on<LoadTrendingMovies>((event, emit) async {
      emit(MoviesLoadingState());

      try {
        final trending = await moviesRepo.getTrending();
        final category = await moviesRepo.getMovieBasedOnCategory(
          MovieCategory.nowPlaying,
        );

        emit(
          MoviesLoadedState(
            trendingMovies: trending,
            categoryMoviesList: category,
            selectedCategory: MovieCategory.nowPlaying,
            isSearching: false,
            searchResults: [],
          ),
        );
      } catch (e) {
        emit(MoviesErrorState(error: e.toString()));
      }
    });

    //! movies based on category
    on<GetMoviesBasedOnCategoryEvent>((event, emit) async {
      final currentState = state;

      if (currentState is MoviesLoadedState) {
        try {
          final movies = await moviesRepo.getMovieBasedOnCategory(
            event.category,
          );

          emit(
            currentState.copyWith(
              categoryMoviesList: movies,
              selectedCategory: event.category,
            ),
          );
        } catch (e) {
          emit(MoviesErrorState(error: e.toString()));
        }
      }
    });
  }
}
