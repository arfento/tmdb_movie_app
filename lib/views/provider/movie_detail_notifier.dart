// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

import 'package:tmdb_movies_app/common/state_enum.dart';
import 'package:tmdb_movies_app/data/models/entities/movie.dart';
import 'package:tmdb_movies_app/data/models/entities/movie_detail.dart';
import 'package:tmdb_movies_app/data/usecases/movie_usecase/get_movie_detail.dart';
import 'package:tmdb_movies_app/data/usecases/movie_usecase/get_movie_recommendations.dart';
import 'package:tmdb_movies_app/data/usecases/movie_usecase/get_now_playing_movies.dart';
import 'package:tmdb_movies_app/data/usecases/movie_usecase/get_popular_movies.dart';
import 'package:tmdb_movies_app/data/usecases/movie_usecase/get_top_rated_movies.dart';
import 'package:tmdb_movies_app/data/usecases/movie_usecase/get_watchlist_movies.dart';
import 'package:tmdb_movies_app/data/usecases/movie_usecase/get_watchlist_status.dart';
import 'package:tmdb_movies_app/data/usecases/movie_usecase/remove_watchlist.dart';
import 'package:tmdb_movies_app/data/usecases/movie_usecase/save_watchlist.dart';

class MovieDetailNotifier extends ChangeNotifier {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchlistStatus getWatchlistStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieDetailNotifier({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchlistStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  });

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  late MovieDetail _movie;
  MovieDetail get movie => _movie;

  RequestState _movieState = RequestState.Empty;
  RequestState get movieState => _movieState;

  List<Movie> _movieRecommendations = [];
  List<Movie> get movieRecommendations => _movieRecommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  bool _isAddedtoWatchlist = false;
  bool get isAddedtoWatchlist => _isAddedtoWatchlist;

  Future<void> fetchMovieDetail(int id) async {
    _movieState = RequestState.Loading;
    notifyListeners();

    final detailResult = await getMovieDetail.execute(id);
    final recommedationResult = await getMovieRecommendations.execute(id);

    detailResult.fold(
      (failure) {
        _movieState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (result) {
        _recommendationState = RequestState.Loading;
        _movie = result;
        notifyListeners();
        recommedationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
            notifyListeners();
          },
          (result) {
            _recommendationState = RequestState.Loaded;
            _movieRecommendations = result;
          },
        );
        _movieState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> addWatchlist(MovieDetail movie) async {
    final result = await saveWatchlist.execute(movie);

    result.fold(
      (failure) {
        _watchlistMessage = failure.message;
      },
      (resultMessage) {
        _watchlistMessage = resultMessage;
      },
    );
    await loadWatchlistStatus(movie.id);
  }

  Future<void> removeFromWatchlist(MovieDetail movie) async {
    final result = await removeWatchlist.execute(movie);

    result.fold(
      (failure) {
        _watchlistMessage = failure.message;
      },
      (resultMessage) {
        _watchlistMessage = resultMessage;
      },
    );
    await loadWatchlistStatus(movie.id);
  }

  loadWatchlistStatus(int id) async {
    final result = await getWatchlistStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
