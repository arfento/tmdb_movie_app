part of 'tv_season_bloc.dart';

abstract class TvSeasonState extends Equatable {
  const TvSeasonState();

  @override
  List<Object> get props => [];
}

class TvSeasonInitial extends TvSeasonState {}

class TvSeasonEmpty extends TvSeasonState {}

class TvSeasonLoading extends TvSeasonState {}

class TvSeasonError extends TvSeasonState {
  final String messsage;

  const TvSeasonError(this.messsage);

  @override
  List<Object> get props => [messsage];
}

class TvSeasonHasData extends TvSeasonState {
  final TvSeason tvSeason;

  const TvSeasonHasData(this.tvSeason);

  @override
  List<Object> get props => [tvSeason];
}
