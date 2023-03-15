import 'genre_model.dart';
import 'season_model.dart';
import '../../domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TvDetailResponse extends Equatable {
  TvDetailResponse(
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

  final String? backdropPath;
  final String firstAirDate;
  final List<GenreModel> genres;
  final int id;
  final String name;
  final int numberOfSeasons;
  final String overview;
  final String? posterPath;
  final List<SeasonModel> seasons;
  final double voteAverage;
  final int voteCount;

  factory TvDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvDetailResponse(
          backdropPath: json["backdrop_path"],
          firstAirDate: json["first_air_date"],
          genres: List<GenreModel>.from(
              json["genres"].map((x) => GenreModel.fromJson(x))),
          id: json["id"],
          name: json["name"],
          numberOfSeasons: json["number_of_seasons"],
          overview: json["overview"],
          posterPath: json["poster_path"],
          seasons: List<SeasonModel>.from(
              json["seasons"].map((x) => SeasonModel.fromJson(x))),
          voteAverage: json["vote_average"],
          voteCount: json["vote_count"]);

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "first_air_date": firstAirDate,
        "genres": List<dynamic>.from(genres.map((e) => e.toJson())),
        "id": id,
        "name": name,
        "number_of_seasons": numberOfSeasons,
        "overview": overview,
        "poster_path": posterPath,
        "seasons": List<dynamic>.from(
          seasons.map(
            (e) => e.toJson(),
          ),
        ),
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  TvDetail toEntity() {
    return TvDetail(
        backdropPath: this.backdropPath,
        firstAirDate: this.firstAirDate,
        genres: this.genres.map((e) => e.toEntity()).toList(),
        id: this.id,
        name: this.name,
        numberOfSeasons: this.numberOfSeasons,
        overview: this.overview,
        posterPath: this.posterPath,
        seasons: this.seasons.map((e) => e.toEntity()).toList(),
        voteAverage: this.voteAverage,
        voteCount: this.voteCount);
  }

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
