import 'episode.dart';
import 'package:equatable/equatable.dart';

class TvSeason extends Equatable {
  int id;
  int seasonNumber;
  String name;
  List<Episode> episodes;

  TvSeason({
    required this.id,
    required this.seasonNumber,
    required this.name,
    required this.episodes,
  });


  @override
  List<Object?> get props => [
    id,
    seasonNumber,
    name,
    episodes
  ];
}
