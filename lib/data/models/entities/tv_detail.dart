import 'genre.dart';
import 'season.dart';
import 'package:equatable/equatable.dart';

class TvDetail extends Equatable {
  String? backdropPath;
  String firstAirDate;
  List<Genre> genres;
  int id;
  String name;
  int numberOfSeasons;
  String overview;
  String? posterPath;
  List<Season> seasons;
  double voteAverage;
  int voteCount;

  TvDetail(
      {required this.backdropPath,
      required this.firstAirDate,
      required this.genres,
      required this.id,
      required this.name,
      required this.numberOfSeasons,
      required this.overview,
      required this.posterPath,
      required this.seasons,
      required this.voteAverage,
      required this.voteCount});

  @override
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        genres,
        id,
        name,
        numberOfSeasons,
        overview,
        posterPath,
        seasons,
        voteAverage,
        voteCount
      ];
}
