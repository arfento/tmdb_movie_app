import 'package:equatable/equatable.dart';

class Episode extends Equatable {
  int episodeNumber;
  int id;
  String name;
  String overview;
  String? stillPath;

  Episode(
      {required this.episodeNumber,
      required this.id,
      required this.name,
      required this.overview,
      required this.stillPath});

  @override
  List<Object?> get props => [episodeNumber, id, name, overview, stillPath];
}
