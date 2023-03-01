import 'package:dartz/dartz.dart';
import 'package:tmdb_movies_app/common/failure.dart';
import 'package:tmdb_movies_app/data/models/entities/movie_detail.dart';
import 'package:tmdb_movies_app/data/repositories/movie_repository.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
