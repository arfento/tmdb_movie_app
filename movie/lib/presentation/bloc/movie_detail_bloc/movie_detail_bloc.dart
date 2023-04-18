import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/movie_usecase/get_movie_detail.dart';
import 'package:movie/domain/usecases/movie_usecase/get_movie_recommendations.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
  }) : super(MovieDetailEmpty()) {
    on<FetchMovieDetail>((event, emit) async {
      final id = event.id;

      emit(MovieDetailLoading());
      final detailResult = await getMovieDetail.execute(id);
      final recommendationResult = await getMovieRecommendations.execute(id);

      detailResult.fold((failure) {
        emit(MovieDetailError(failure.message));
      }, (movieDetail) {
        emit(MovieDetailLoading());
        recommendationResult.fold(
          (failure) {
            emit(MovieDetailError(failure.message));
          },
          (movieRecommendations) {
            emit(MovieDetailHasData(movieDetail, movieRecommendations));
          },
        );
      });
    });
  }
}
