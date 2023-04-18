// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie_detail.dart';

import 'package:watchlist/domain/usecases/remove_watchlist.dart';
import 'package:watchlist/domain/usecases/get_watchlist_status.dart';
import 'package:watchlist/domain/usecases/save_watchlist.dart';

part 'movie_watchlist_event.dart';
part 'movie_watchlist_state.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  final GetWatchlistStatus getWatchlistStatus;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  MovieWatchlistBloc({
    required this.saveWatchlist,
    required this.removeWatchlist,
    required this.getWatchlistStatus,
  }) : super(MovieWatchlistInitial()) {
    on<MovieWatchlistEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<LoadWatchlistStatus>((((event, emit) async {
      final id = event.id;
      final result = await getWatchlistStatus.execute(id);

      emit(SuccessLoadWatchlist(result));
    })));
    on<AddToWatchlist>(
      ((event, emit) async {
        final movie = event.movieDetail;
        final result = await saveWatchlist.execute(movie);

        result.fold(
          (failure) {
            emit(FailedAddOrRemoveWatchlist(message: failure.message));
          },
          (success) {
            emit(SuccessAddOrRemoveWatchlist(message: success));
          },
        );
        add(LoadWatchlistStatus(event.movieDetail.id));
      }),
    );
    on<RemoveFromWatchList>(
      ((event, emit) async {
        final movie = event.movieDetail;
        final result = await removeWatchlist.execute(movie);

        result.fold(
          (failure) {
            emit(FailedAddOrRemoveWatchlist(message: failure.message));
          },
          (success) {
            emit(SuccessAddOrRemoveWatchlist(message: success));
          },
        );
        add(LoadWatchlistStatus(event.movieDetail.id));
      }),
    );
  }
}
