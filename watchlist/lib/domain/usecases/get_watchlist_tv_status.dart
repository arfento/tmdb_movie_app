import 'package:tv/data/repositories/tv_repository.dart';

class GetWatchlistTvStatus {
  TvRepository repository;

  GetWatchlistTvStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isTvAddedToWatchlist(id);
  }
}
