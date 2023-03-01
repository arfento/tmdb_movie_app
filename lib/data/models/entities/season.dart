import 'package:equatable/equatable.dart';

class Season extends Equatable {
  int id;
  int seasonNumber;
  String name;
  String? posterPath;

  Season(
      {required this.id,
      required this.seasonNumber,
      required this.name,
      required this.posterPath});

  @override
  List<Object?> get props => [
        id,
        seasonNumber,
        name,
        posterPath,
      ];
}
