import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/data/repositories/tv_repository.dart';
import 'package:tv/domain/entities/tv.dart';

class GetPopularTvs {
  TvRepository repository;

  GetPopularTvs(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getPopularTvs();
  }
}
