// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/movie_usecase/get_now_playing_movies.dart';

part 'now_playing_movies_event.dart';
part 'now_playing_movies_state.dart';

class NowPlayingMoviesBloc
    extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  NowPlayingMoviesBloc({
    required this.getNowPlayingMovies,
  }) : super(NowPlayingMoviesInitial()) {
    on<NowPlayingMoviesEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchNowPlayingMovies>(((event, emit) async {
      emit(NowPlayingMovieLoading());
      final movies = await getNowPlayingMovies.execute();

      movies.fold(
        (failure) => emit(NowPlayingMovieError(failure.message)),
        (movies) => emit(NowPlayingMovieHasData(movies)),
      );
    }));
  }
}
