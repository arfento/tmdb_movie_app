part of 'now_playing_movies_bloc.dart';

abstract class NowPlayingMoviesState extends Equatable {
  const NowPlayingMoviesState();

  @override
  List<Object> get props => [];
}

class NowPlayingMoviesInitial extends NowPlayingMoviesState {}

class NowPlayingMovieEmpty extends NowPlayingMoviesState {}

class NowPlayingMovieLoading extends NowPlayingMoviesState {}

class NowPlayingMovieError extends NowPlayingMoviesState {
  final String message;

  const NowPlayingMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingMovieHasData extends NowPlayingMoviesState {
  final List<Movie> listMovie;

  const NowPlayingMovieHasData(this.listMovie);

  @override
  List<Object> get props => [listMovie];
}
