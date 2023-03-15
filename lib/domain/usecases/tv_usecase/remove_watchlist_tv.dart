import 'package:dartz/dartz.dart';
import 'package:tmdb_movies_app/common/failure.dart';
import 'package:tmdb_movies_app/data/repositories/tv_repository.dart';
import 'package:tmdb_movies_app/domain/entities/movie_detail.dart';
import 'package:tmdb_movies_app/data/repositories/movie_repository.dart';
import 'package:tmdb_movies_app/domain/entities/tv_detail.dart';

class RemoveWatchlistTv {
  TvRepository repository;

  RemoveWatchlistTv(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tvDetail) {
    return repository.removeWatchlistTv(tvDetail);
  }
}
