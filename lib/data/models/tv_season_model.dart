import '../../domain/entities/tv_season.dart';
import 'package:equatable/equatable.dart';

import 'episode_model.dart';

class TvSeasonModel extends Equatable {
  final String? name;
  final int id;
  final int seasonNumber;
  final List<EpisodeModel> episodes;

  TvSeasonModel({
    required this.name,
    required this.id,
    required this.seasonNumber,
    required this.episodes,
  });

  factory TvSeasonModel.fromJson(Map<String, dynamic> json) => TvSeasonModel(
        episodes: List<EpisodeModel>.from(
            json["episodes"].map((x) => EpisodeModel.fromJson(x))),
        id: json["id"],
        name: json["name"],
        seasonNumber: json["season_number"],
      );

  Map<String, dynamic> toJson() => {
        "episodes": List<dynamic>.from(episodes.map((e) => e.toJson())),
        "id": id,
        "name": name,
        "season_number": seasonNumber,
      };

  TvSeason toEntity() {
    return TvSeason(
      episodes: episodes.map((e) => e.toEntity()).toList(),
      id: id,
      name: name!,
      seasonNumber: seasonNumber,
    );
  }

  @override
  List<Object?> get props => [name, id, seasonNumber, episodes];
}
