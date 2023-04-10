part of 'tv_watchlist_bloc.dart';

abstract class TvWatchlistEvent extends Equatable {
  const TvWatchlistEvent();

  @override
  List<Object> get props => [];
}

class LoadWatchlistStatus extends TvWatchlistEvent {
  final int id;
  const LoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class AddToWatchlist extends TvWatchlistEvent {
  final TvDetail tvDetail;

  const AddToWatchlist(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class RemoveFromWatchList extends TvWatchlistEvent {
  final TvDetail tvDetail;

  const RemoveFromWatchList(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}
