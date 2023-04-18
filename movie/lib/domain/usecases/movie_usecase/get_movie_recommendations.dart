import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/data/repositories/movie_repository.dart';
import 'package:movie/domain/entities/movie.dart';

class GetMovieRecommendations {
  final MovieRepository repository;

  GetMovieRecommendations(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getMovieRecommendations(id);
  }
}
