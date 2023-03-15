import 'package:dartz/dartz.dart';
import 'package:tmdb_movies_app/data/repositories/tv_repository.dart';

import '../../../common/failure.dart';
import '../../entities/tv_season.dart';

class GetTvSeason {
  TvRepository tvRepository;

  GetTvSeason(this.tvRepository);

  Future<Either<Failure, TvSeason>> execute(int tvId, int seasonNumber) {
    return tvRepository.getTvSeason(tvId, seasonNumber);
  }
}
