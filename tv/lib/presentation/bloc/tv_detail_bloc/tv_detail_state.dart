part of 'tv_detail_bloc.dart';

abstract class TvDetailState extends Equatable {
  const TvDetailState();

  @override
  List<Object> get props => [];
}

class TvDetailInitial extends TvDetailState {}

class TvDetailEmpty extends TvDetailState {}

class TvDetailLoading extends TvDetailState {}

class TvDetailError extends TvDetailState {
  final String message;

  TvDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class TvDetailHasData extends TvDetailState {
  final TvDetail tvDetail;
  final List<Tv> tvRecommendations;

  TvDetailHasData(
    this.tvDetail,
    this.tvRecommendations,
  );

  @override
  List<Object> get props => [tvDetail, tvRecommendations];
}
