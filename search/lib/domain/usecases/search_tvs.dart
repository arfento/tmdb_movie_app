import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/data/repositories/tv_repository.dart';
import 'package:tv/domain/entities/tv.dart';

class SearchTvs {
  TvRepository repository;

  SearchTvs(this.repository);

  Future<Either<Failure, List<Tv>>> execute(String query) {
    return repository.searchTv(query);
  }
}
