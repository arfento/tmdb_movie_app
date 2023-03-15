// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Season extends Equatable {
  int id;
  int seasonNumber;
  String name;
  String? posterPath;
  int episodeCount;
  String? airDate;

  Season({
    required this.id,
    required this.seasonNumber,
    required this.name,
    this.posterPath,
    required this.episodeCount,
    required this.airDate,
  });

  @override
  List<Object> get props {
    return [
      id,
      seasonNumber,
      name,
      posterPath!,
      episodeCount,
      airDate!,
    ];
  }
}
