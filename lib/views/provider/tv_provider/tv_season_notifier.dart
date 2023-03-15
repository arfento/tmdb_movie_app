import '../../../domain/entities/tv_season.dart';
import 'package:flutter/cupertino.dart';

import '../../../common/state_enum.dart';
import '../../../domain/usecases/tv_usecase/get_tv_season.dart';

class TvSeasonNotifier extends ChangeNotifier {
  final GetTvSeason getTvSeason;

  TvSeasonNotifier({required this.getTvSeason});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  late TvSeason _tvSeasonResult;
  TvSeason get tvSeason => _tvSeasonResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSeasons(int id, int seasonNumber) async {
    _state = RequestState.Loading;
    notifyListeners();
    final tvSeasons = await getTvSeason.execute(id, seasonNumber);
    tvSeasons.fold((failure) {
      _state = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (season) {
      _state = RequestState.Loaded;
      _tvSeasonResult = season;
      notifyListeners();
    });
  }
}
