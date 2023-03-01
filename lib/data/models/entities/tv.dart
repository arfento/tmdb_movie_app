import 'package:equatable/equatable.dart';

class Tv extends Equatable {
  String? posterPath;
  int id;
  String? name;
  String overview;

  Tv({
    required this.id,
    required this.posterPath,
    required this.name,
    required this.overview,
  });

  @override
  List<Object?> get props => [posterPath, id, name, overview];
}
