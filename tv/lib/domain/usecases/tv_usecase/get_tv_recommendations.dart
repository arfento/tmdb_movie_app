import 'package:core/common/failure.dart';
// ignore: depend_on_referenced_packages
import 'package:dartz/dartz.dart';
import 'package:tv/data/repositories/tv_repository.dart';
import 'package:tv/domain/entities/tv.dart';

class GetTvRecommendations {
  TvRepository tvRepository;

  GetTvRecommendations(this.tvRepository);

  Future<Either<Failure, List<Tv>>> execute(int id) {
    return tvRepository.getTvRecommendations(id);
  }
}
