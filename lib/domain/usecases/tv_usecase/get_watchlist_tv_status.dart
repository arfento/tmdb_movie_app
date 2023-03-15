import 'package:tmdb_movies_app/data/repositories/tv_repository.dart';

import '../../../data/repositories/movie_repository.dart';

class GetWatchlistTvStatus {
  TvRepository repository;

  GetWatchlistTvStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isTvAddedToWatchlist(id);
  }
}
