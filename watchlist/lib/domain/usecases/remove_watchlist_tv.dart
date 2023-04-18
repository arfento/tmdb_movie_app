import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/data/repositories/tv_repository.dart';
import 'package:tv/domain/entities/tv_detail.dart';

class RemoveWatchlistTv {
  TvRepository repository;

  RemoveWatchlistTv(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tvDetail) {
    return repository.removeWatchlistTv(tvDetail);
  }
}
