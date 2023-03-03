import 'package:flutter/cupertino.dart';

import 'package:tmdb_movies_app/common/state_enum.dart';
import 'package:tmdb_movies_app/data/models/entities/movie.dart';
import 'package:tmdb_movies_app/data/usecases/movie_usecase/get_top_rated_movies.dart';

class TopRatedMoviesNotifier extends ChangeNotifier {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesNotifier({
    required this.getTopRatedMovies,
  });

  var _movies = <Movie>[];
  List<Movie> get movies => _movies;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedMovies() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedMovies.execute();

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
