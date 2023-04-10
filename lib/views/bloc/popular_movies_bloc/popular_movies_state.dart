part of 'popular_movies_bloc.dart';

abstract class PopularMoviesState extends Equatable {
  const PopularMoviesState();

  @override
  List<Object> get props => [];
}

class PopularMoviesInitial extends PopularMoviesState {}

class PopularMoviesEmpty extends PopularMoviesState {}

class PopularMoviesLoading extends PopularMoviesState {}

class PopularMoviesError extends PopularMoviesState {
  final String message;

  PopularMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularMoviesHasData extends PopularMoviesState {
  final List<Movie> listMovie;

  PopularMoviesHasData(this.listMovie);

  @override
  List<Object> get props => [listMovie];
}
