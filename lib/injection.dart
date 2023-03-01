import 'package:get_it/get_it.dart';
import 'package:tmdb_movies_app/data/datasources/db/database_helper.dart';
import 'package:tmdb_movies_app/data/datasources/movie_local_data_source.dart';
import 'package:tmdb_movies_app/data/datasources/movie_remote_data_source.dart';
import 'package:tmdb_movies_app/data/usecases/movie_usecase/get_movie_detail.dart';
import 'package:tmdb_movies_app/data/usecases/movie_usecase/get_movie_recommendations.dart';
import 'package:tmdb_movies_app/data/usecases/movie_usecase/get_now_playing_movies.dart';
import 'package:tmdb_movies_app/data/usecases/movie_usecase/get_popular_movies.dart';
import 'package:tmdb_movies_app/data/usecases/movie_usecase/get_top_rated_movies.dart';
import 'package:tmdb_movies_app/data/usecases/movie_usecase/get_watchlist_status.dart';
import 'package:tmdb_movies_app/data/usecases/movie_usecase/remove_watchlist.dart';
import 'package:tmdb_movies_app/data/usecases/movie_usecase/save_watchlist.dart';
import 'package:tmdb_movies_app/data/usecases/movie_usecase/search_movies.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  //provider

  //use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));

  // data source
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovielocalDataSourceImpl(databaseHelper: locator()));

  // helpers
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
