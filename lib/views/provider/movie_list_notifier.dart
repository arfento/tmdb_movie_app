// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

import 'package:tmdb_movies_app/common/state_enum.dart';
import 'package:tmdb_movies_app/data/models/entities/movie.dart';
import 'package:tmdb_movies_app/data/usecases/movie_usecase/get_now_playing_movies.dart';
import 'package:tmdb_movies_app/data/usecases/movie_usecase/get_popular_movies.dart';
import 'package:tmdb_movies_app/data/usecases/movie_usecase/get_top_rated_movies.dart';

class MovieListNotifier extends ChangeNotifier {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  MovieListNotifier({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  });

  var _nowPlayingMovie = <Movie>[];
  List<Movie> get nowPlayingMovies => _nowPlayingMovie;

  RequestState _nowPlayingState = RequestState.Empty;
  RequestState get nowPlayingState => _nowPlayingState;

  var _popularMovies = <Movie>[];
  List<Movie> get popularMovies => _popularMovies;

  RequestState _popularState = RequestState.Empty;
  RequestState get popularState => _popularState;

  var _topRatedMovies = <Movie>[];
  List<Movie> get topRatedMovies => _topRatedMovies;

  RequestState _topRatedMoviesState = RequestState.Empty;
  RequestState get topRatedMoviesState => _topRatedMoviesState;

  String _message = '';
  String get message => _message;

  Future<void> fetchNowPlayingMovies() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingMovies.execute();
    result.fold(
      (failure) {
        _nowPlayingState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (result) {
        _nowPlayingState = RequestState.Loaded;
        _nowPlayingMovie = result;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularMovies() async {
    _popularState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularMovies.execute();
    result.fold(
      (failure) {
        _popularState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (result) {
        _popularState = RequestState.Loaded;
        _popularMovies = result;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedMovies() async {
    _topRatedMoviesState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedMovies.execute();
    result.fold(
      (failure) {
        _topRatedMoviesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (result) {
        _topRatedMoviesState = RequestState.Loaded;
        _topRatedMovies = result;
        notifyListeners();
      },
    );
  }
}
