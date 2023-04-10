import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb_movies_app/domain/entities/tv_detail.dart';
import 'package:tmdb_movies_app/domain/usecases/tv_usecase/get_watchlist_tv_status.dart';
import 'package:tmdb_movies_app/domain/usecases/tv_usecase/remove_watchlist_tv.dart';
import 'package:tmdb_movies_app/domain/usecases/tv_usecase/save_watchlist_tv.dart';

part 'tv_watchlist_event.dart';
part 'tv_watchlist_state.dart';

class TvWatchlistBloc extends Bloc<TvWatchlistEvent, TvWatchlistState> {
  final SaveWatchlistTv saveWatchlist;
  final RemoveWatchlistTv removeWatchlist;
  final GetWatchlistTvStatus getWatchlistStatus;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  TvWatchlistBloc(
      {required this.saveWatchlist,
      required this.removeWatchlist,
      required this.getWatchlistStatus})
      : super(TvWatchlistEmpty()) {
    on<TvWatchlistEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<LoadWatchlistStatus>((((event, emit) async {
      final id = event.id;
      final result = await getWatchlistStatus.execute(id);

      emit(SuccessLoadWatchlist(result));
    })));
    on<AddToWatchlist>(
      ((event, emit) async {
        final tv = event.tvDetail;
        final result = await saveWatchlist.execute(tv);

        result.fold(
          (failure) {
            emit(FailedAddOrRemoveWatchlist(message: failure.message));
          },
          (success) {
            emit(SuccessAddOrRemoveWatchlist(message: success));
          },
        );
        add(LoadWatchlistStatus(event.tvDetail.id));
      }),
    );
    on<RemoveFromWatchList>(
      ((event, emit) async {
        final tv = event.tvDetail;
        final result = await removeWatchlist.execute(tv);

        result.fold(
          (failure) {
            emit(FailedAddOrRemoveWatchlist(message: failure.message));
          },
          (success) {
            emit(SuccessAddOrRemoveWatchlist(message: success));
          },
        );
        add(LoadWatchlistStatus(event.tvDetail.id));
      }),
    );
  }
}
