import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/movie_usecase/get_popular_movies.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies popularMovies;
  PopularMoviesBloc({
    required this.popularMovies,
  }) : super(PopularMoviesInitial()) {
    on<PopularMoviesEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchPopularMovies>(((event, emit) async {
      emit(PopularMoviesLoading());
      final result = await popularMovies.execute();
      result.fold(
        (failure) => emit(PopularMoviesError(failure.message)),
        (movies) => emit(PopularMoviesHasData(movies)),
      );
    }));
  }
}
