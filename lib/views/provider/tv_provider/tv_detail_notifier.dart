// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

import 'package:tmdb_movies_app/common/state_enum.dart';
import 'package:tmdb_movies_app/domain/entities/tv.dart';
import 'package:tmdb_movies_app/domain/entities/tv_detail.dart';
import 'package:tmdb_movies_app/domain/usecases/tv_usecase/get_tv_detail.dart';
import 'package:tmdb_movies_app/domain/usecases/tv_usecase/get_tv_recommendations.dart';
import 'package:tmdb_movies_app/domain/usecases/tv_usecase/get_watchlist_tv_status.dart';
import 'package:tmdb_movies_app/domain/usecases/tv_usecase/remove_watchlist_tv.dart';
import 'package:tmdb_movies_app/domain/usecases/tv_usecase/save_watchlist_tv.dart';

class TvDetailNotifier extends ChangeNotifier {
  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;
  final GetWatchlistTvStatus getWatchlistTvStatus;
  final SaveWatchlistTv saveWatchlistTv;
  final RemoveWatchlistTv removeWatchlistTv;

  TvDetailNotifier({
    required this.getTvDetail,
    required this.getTvRecommendations,
    required this.getWatchlistTvStatus,
    required this.saveWatchlistTv,
    required this.removeWatchlistTv,
  });

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  late TvDetail _tvDetail;
  TvDetail get tvDetail => _tvDetail;

  RequestState _tvState = RequestState.Empty;
  RequestState get tvState => _tvState;

  List<Tv> _tvRecommendations = [];
  List<Tv> get tvRecommendations => _tvRecommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  bool _isAddedtoWatchlist = false;
  bool get isAddedtoWatchlist => _isAddedtoWatchlist;

  Future<void> fetchTvDetail(int id) async {
    _tvState = RequestState.Loading;
    notifyListeners();

    final detailResult = await getTvDetail.execute(id);
    final recommedationResult = await getTvRecommendations.execute(id);

    detailResult.fold(
      (failure) {
        _tvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (result) {
        _recommendationState = RequestState.Loading;
        _tvDetail = result;
        notifyListeners();
        recommedationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
            notifyListeners();
          },
          (result) {
            _recommendationState = RequestState.Loaded;
            _tvRecommendations = result;
          },
        );
        _tvState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> addWatchlist(TvDetail tvDetail) async {
    final result = await saveWatchlistTv.execute(tvDetail);

    result.fold(
      (failure) {
        _watchlistMessage = failure.message;
      },
      (resultMessage) {
        _watchlistMessage = resultMessage;
      },
    );
    await loadWatchlistStatus(tvDetail.id);
  }

  Future<void> removeFromWatchlist(TvDetail tvDetail) async {
    final result = await removeWatchlistTv.execute(tvDetail);

    result.fold(
      (failure) {
        _watchlistMessage = failure.message;
      },
      (resultMessage) {
        _watchlistMessage = resultMessage;
      },
    );
    await loadWatchlistStatus(tvDetail.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchlistTvStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
