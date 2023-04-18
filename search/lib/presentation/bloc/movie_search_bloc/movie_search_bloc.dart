import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/domain/usecases/search_movies.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (event, mapper) => event.debounceTime(duration).flatMap(mapper);
}

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies _searchMovies;
  MovieSearchBloc(
    this._searchMovies,
  ) : super(MovieSearchEmpty()) {
    on<OnQueryMovieChanged>(
      ((event, emit) async {
        final query = event.query;

        emit(MovieSearchLoading());
        final result = await _searchMovies.execute(query);

        result.fold(
          (failure) => emit(MovieSearchError(failure.message)),
          (result) => emit(MovieSearchHasData(result)),
        );
      }),
      transformer: debounce(
        const Duration(milliseconds: 100),
      ),
    );
  }
}
