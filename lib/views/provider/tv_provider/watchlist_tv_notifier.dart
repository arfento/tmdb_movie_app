import 'package:flutter/cupertino.dart';

import 'package:tmdb_movies_app/common/state_enum.dart';
import 'package:tmdb_movies_app/domain/entities/tv.dart';
import 'package:tmdb_movies_app/domain/usecases/tv_usecase/get_watchlist_tvs.dart';

class WatchlistTvNotifier extends ChangeNotifier {
  final GetWatchlistTvs getWatchlistTvs;

  WatchlistTvNotifier({
    required this.getWatchlistTvs,
  });

  var _tvs = <Tv>[];
  List<Tv> get tvs => _tvs;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchWatchlistTvs() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTvs.execute();

    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (result) {
        _state = RequestState.Loaded;
        _tvs = result;
        notifyListeners();
      },
    );
  }
}
