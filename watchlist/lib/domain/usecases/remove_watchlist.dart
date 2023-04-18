import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/data/repositories/movie_repository.dart';
import 'package:movie/domain/entities/movie_detail.dart';

class RemoveWatchlist {
  final MovieRepository repository;

  RemoveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.removeWatchlist(movie);
  }
}
