import '../../domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

class TvModel extends Equatable {
  TvModel({
    required this.id,
    required this.posterPath,
    required this.name,
    required this.overview,
  });

  final int id;
  final String? posterPath;
  final String name;
  final String overview;

  factory TvModel.fromJson(Map<String, dynamic> json) => TvModel(
      id: json["id"],
      posterPath: json["poster_path"],
      name: json["name"],
      overview: json["overview"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "poster_path": posterPath,
        "name": name,
        "overview": overview,
      };

  Tv toEntity() {
    return Tv(
      id: this.id,
      posterPath: this.posterPath,
      name: this.name,
      overview: this.overview,
    );
  }

  @override
  List<Object?> get props => [
        id,
        posterPath,
        name,
        overview,
      ];
}
