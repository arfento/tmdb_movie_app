part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();

  @override
  List<Object> get props => [];
}

class MovieWatchlistInitial extends MovieWatchlistState {}

class MovieWatchlistEmpty extends MovieWatchlistState {}

class SuccessLoadWatchlist extends MovieWatchlistState {
  final bool isAddedToWatchlist;

  const SuccessLoadWatchlist(this.isAddedToWatchlist);

  @override
  List<Object> get props => [isAddedToWatchlist];
}

class SuccessAddOrRemoveWatchlist extends MovieWatchlistState {
  final String message;

  const SuccessAddOrRemoveWatchlist({
    this.message = "",
  });

  @override
  List<Object> get props => [message];
}

class FailedAddOrRemoveWatchlist extends MovieWatchlistState {
  final String message;

  const FailedAddOrRemoveWatchlist({this.message = ""});

  @override
  List<Object> get props => [message];
}
