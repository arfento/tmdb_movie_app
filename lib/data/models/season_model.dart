import 'package:equatable/equatable.dart';

import '../../domain/entities/season.dart';

class SeasonModel extends Equatable {
  final int id;
  final int seasonNumber;
  final String name;
  final String? airDate;
  final int episodeCount;

  SeasonModel(
      {required this.id,
      required this.seasonNumber,
      required this.name,
      required this.airDate,
      required this.episodeCount});

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
      id: json["id"],
      seasonNumber: json["season_number"],
      name: json["name"],
      airDate: json["air_date"],
      episodeCount: json["episode_count"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "season_number": seasonNumber,
        "name": name,
        "air_date": airDate,
        "episode_count": episodeCount,
      };

  Season toEntity() {
    return Season(
        id: id,
        seasonNumber: seasonNumber,
        name: name,
        airDate: airDate,
        episodeCount: episodeCount);
  }

  @override
  List<Object?> get props => [id, seasonNumber, name, airDate, episodeCount];
}
