import 'package:flutter/cupertino.dart';

import 'package:tmdb_movies_app/common/state_enum.dart';
import 'package:tmdb_movies_app/data/models/entities/movie.dart';
import 'package:tmdb_movies_app/data/usecases/movie_usecase/get_popular_movies.dart';

class PopularMoviesNotifier extends ChangeNotifier {
  final GetPopularMovies getPopularMovies;

  PopularMoviesNotifier({
    required this.getPopularMovies,
  });

  var _movies = <Movie>[];
  List<Movie> get movies => _movies;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularMovies() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularMovies.execute();

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
