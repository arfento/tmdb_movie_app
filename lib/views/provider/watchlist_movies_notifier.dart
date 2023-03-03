import 'package:flutter/cupertino.dart';

import 'package:tmdb_movies_app/common/state_enum.dart';
import 'package:tmdb_movies_app/data/models/entities/movie.dart';
import 'package:tmdb_movies_app/data/usecases/movie_usecase/get_watchlist_movies.dart';

class WatchlistMovieNotifier extends ChangeNotifier {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMovieNotifier({
    required this.getWatchlistMovies,
  });

  var _movies = <Movie>[];
  List<Movie> get movies => _movies;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchWatchlistMovies() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistMovies.execute();

    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (result) {
        _state = RequestState.Loaded;
        _movies = result;
        notifyListeners();
      },
    );
  }
}
