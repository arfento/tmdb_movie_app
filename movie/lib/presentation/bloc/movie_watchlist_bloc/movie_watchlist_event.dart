part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistEvent extends Equatable {
  const MovieWatchlistEvent();

  @override
  List<Object> get props => [];
}

class LoadWatchlistStatus extends MovieWatchlistEvent {
  final int id;
  const LoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class AddToWatchlist extends MovieWatchlistEvent {
  final MovieDetail movieDetail;

  const AddToWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class RemoveFromWatchList extends MovieWatchlistEvent {
  final MovieDetail movieDetail;

  const RemoveFromWatchList(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}
