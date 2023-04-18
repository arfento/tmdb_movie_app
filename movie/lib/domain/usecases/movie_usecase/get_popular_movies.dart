import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/data/repositories/movie_repository.dart';
import 'package:movie/domain/entities/movie.dart';

class GetPopularMovies {
  final MovieRepository repository;

  GetPopularMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getPopularMovies();
  }
}
