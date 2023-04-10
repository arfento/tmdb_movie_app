part of 'tv_watchlist_bloc.dart';

abstract class TvWatchlistState extends Equatable {
  const TvWatchlistState();

  @override
  List<Object> get props => [];
}

class TvWatchlistInitial extends TvWatchlistState {}

class TvWatchlistEmpty extends TvWatchlistState {}

class SuccessLoadWatchlist extends TvWatchlistState {
  final bool isAddedToWatchlist;

  const SuccessLoadWatchlist(this.isAddedToWatchlist);

  @override
  List<Object> get props => [isAddedToWatchlist];
}

class SuccessAddOrRemoveWatchlist extends TvWatchlistState {
  final String message;

  const SuccessAddOrRemoveWatchlist({
    this.message = "",
  });

  @override
  List<Object> get props => [message];
}

class FailedAddOrRemoveWatchlist extends TvWatchlistState {
  final String message;

  const FailedAddOrRemoveWatchlist({this.message = ""});

  @override
  List<Object> get props => [message];
}
