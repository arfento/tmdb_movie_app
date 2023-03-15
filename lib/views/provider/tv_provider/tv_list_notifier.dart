// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

import 'package:tmdb_movies_app/common/state_enum.dart';
import 'package:tmdb_movies_app/domain/entities/tv.dart';
import 'package:tmdb_movies_app/domain/usecases/tv_usecase/get_on_the_air_tvs.dart';
import 'package:tmdb_movies_app/domain/usecases/tv_usecase/get_popular_tvs.dart';
import 'package:tmdb_movies_app/domain/usecases/tv_usecase/get_top_rated_tvs.dart';

class TvListNotifier extends ChangeNotifier {
  final GetOnTheAirTvs getOnTheAirTvs;
  final GetPopularTvs getPopularTvs;
  final GetTopRatedTvs getTopRatedTvs;

  TvListNotifier({
    required this.getOnTheAirTvs,
    required this.getPopularTvs,
    required this.getTopRatedTvs,
  });

  var _onTheAirTvs = <Tv>[];
  List<Tv> get onTheAirTvs => _onTheAirTvs;

  RequestState onTheAirState = RequestState.Empty;
  RequestState get nowPlayingState => onTheAirState;

  var _popularTvs = <Tv>[];
  List<Tv> get popularTvs => _popularTvs;

  RequestState _popularState = RequestState.Empty;
  RequestState get popularState => _popularState;

  var _topRatedTvs = <Tv>[];
  List<Tv> get topRatedTvs => _topRatedTvs;

  RequestState _topRatedTvsState = RequestState.Empty;
  RequestState get topRatedTvsState => _topRatedTvsState;

  String _message = '';
  String get message => _message;

  Future<void> fetchOnTheAirTvs() async {
    onTheAirState = RequestState.Loading;
    notifyListeners();

    final result = await getOnTheAirTvs.execute();
    result.fold(
      (failure) {
        onTheAirState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (result) {
        onTheAirState = RequestState.Loaded;
        _onTheAirTvs = result;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvs() async {
    _popularState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvs.execute();
    result.fold(
      (failure) {
        _popularState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (result) {
        _popularState = RequestState.Loaded;
        _popularTvs = result;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvs() async {
    _topRatedTvsState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvs.execute();
    result.fold(
      (failure) {
        _topRatedTvsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (result) {
        _topRatedTvsState = RequestState.Loaded;
        _topRatedTvs = result;
        notifyListeners();
      },
    );
  }
}
