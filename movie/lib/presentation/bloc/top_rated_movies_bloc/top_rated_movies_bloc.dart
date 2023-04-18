import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/movie_usecase/get_top_rated_movies.dart';

part 'top_rated_movies_event.dart';
part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies topRatedMovies;
  TopRatedMoviesBloc({required this.topRatedMovies})
      : super(TopRatedMoviesInitial()) {
    on<TopRatedMoviesEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchTopRatedMovies>(((event, emit) async {
      emit(TopRatedMoviesLoading());
      final result = await topRatedMovies.execute();
      result.fold(
        (failure) => emit(TopRatedMoviesError(failure.message)),
        (movies) => emit(TopRatedMoviesHasData(movies)),
      );
    }));
  }
}
