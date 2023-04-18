import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/data/repositories/tv_repository.dart';
import 'package:tv/domain/entities/tv.dart';

class GetOnTheAirTvs {
  final TvRepository repository;

  GetOnTheAirTvs(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getOnTheAirTvs();
  }
}
