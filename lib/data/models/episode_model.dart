import '../../domain/entities/episode.dart';
import 'package:equatable/equatable.dart';

class EpisodeModel extends Equatable {
  final int episodeNumber;
  final int id;
  final String name;
  final String overview;
  final String? stillPath;

  EpisodeModel(
      {required this.episodeNumber,
      required this.id,
      required this.name,
      required this.overview,
      required this.stillPath});

  factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
      id: json["id"],
      name: json["name"],
      episodeNumber: json["episode_number"],
      overview: json["overview"],
      stillPath: json["still_path"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "episode_number": episodeNumber,
        "overview": overview,
        "still_path": stillPath,
      };

  Episode toEntity() {
    return Episode(
        id: this.id,
        name: this.name,
        episodeNumber: episodeNumber,
        overview: overview,
        stillPath: stillPath);
  }

  @override
  List<Object?> get props => [episodeNumber, id, name, overview, stillPath];
}
