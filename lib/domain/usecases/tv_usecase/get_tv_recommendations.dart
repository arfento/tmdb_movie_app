import 'package:dartz/dartz.dart';
import 'package:tmdb_movies_app/common/failure.dart';
import 'package:tmdb_movies_app/data/repositories/tv_repository.dart';
import 'package:tmdb_movies_app/domain/entities/tv.dart';

class GetTvRecommendations {
  TvRepository tvRepository;

  GetTvRecommendations(this.tvRepository);

  Future<Either<Failure, List<Tv>>> execute(int id) {
    return tvRepository.getTvRecommendations(id);
  }
}
