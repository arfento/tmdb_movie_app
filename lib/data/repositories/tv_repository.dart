import 'package:dartz/dartz.dart';
import 'package:tmdb_movies_app/common/failure.dart';
import 'package:tmdb_movies_app/data/models/entities/tv.dart';
import 'package:tmdb_movies_app/data/models/entities/tv_detail.dart';
import 'package:tmdb_movies_app/data/models/entities/tv_season.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Tv>>> getOnTheAirTvShows();
  Future<Either<Failure, List<Tv>>> getPopularTvShows();
  Future<Either<Failure, List<Tv>>> getTopRatedTvShows();
  Future<Either<Failure, TvDetail>> getTvDetail(int id);
  Future<Either<Failure, List<Tv>>> getTvRecomendations(int id);
  Future<Either<Failure, List<Tv>>> searchTv(String query);
  Future<Either<Failure, String>> saveWatchList(TvDetail tv);
  Future<Either<Failure, String>> removeWatchList(TvDetail tv);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<Tv>>> getWatchlistTv();
  Future<Either<Failure, List<TvSeason>>> getTvSeasons(int id);
}
