import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/tv_usecase/get_tv_detail.dart';
import 'package:tv/domain/usecases/tv_usecase/get_tv_recommendations.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  TvDetailBloc({
    required this.getTvDetail,
    required this.getTvRecommendations,
  }) : super(TvDetailInitial()) {
    on<TvDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchTvDetail>(
      (((event, emit) async {
        final id = event.id;
        emit(TvDetailLoading());
        final detailResult = await getTvDetail.execute(id);
        final recommendationResult = await getTvRecommendations.execute(id);

        detailResult.fold((failure) {
          emit(TvDetailError(failure.message));
        }, (tvDetail) {
          emit(TvDetailLoading());
          recommendationResult.fold(
            (failure) {
              emit(TvDetailError(failure.message));
            },
            (tvRecommendation) {
              emit(TvDetailHasData(tvDetail, tvRecommendation));
            },
          );
        });
      })),
    );
  }
}
