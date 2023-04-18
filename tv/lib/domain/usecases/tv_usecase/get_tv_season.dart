import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/data/repositories/tv_repository.dart';
import '../../entities/tv_season.dart';

class GetTvSeason {
  TvRepository tvRepository;

  GetTvSeason(this.tvRepository);

  Future<Either<Failure, TvSeason>> execute(int tvId, int seasonNumber) {
    return tvRepository.getTvSeason(tvId, seasonNumber);
  }
}
