import 'package:get_it/get_it.dart';
import 'package:tmdb_movies_app/data/datasources/db/database_helper.dart';
import 'package:tmdb_movies_app/data/datasources/movie_local_data_source.dart';
import 'package:tmdb_movies_app/data/datasources/movie_remote_data_source.dart';
import 'package:tmdb_movies_app/data/repositories/movie_repository.dart';
import 'package:tmdb_movies_app/data/repositories/movie_repository_impl.dart';
import 'package:tmdb_movies_app/data/usecases/movie_usecase/get_movie_detail.dart';
import 'package:tmdb_movies_app/data/usecases/movie_usecase/get_movie_recommendations.dart';
import 'package:tmdb_movies_app/data/usecases/movie_usecase/get_now_playing_movies.dart';
import 'package:tmdb_movies_app/data/usecases/movie_usecase/get_popular_movies.dart';
import 'package:tmdb_movies_app/data/usecases/movie_usecase/get_top_rated_movies.dart';
import 'package:tmdb_movies_app/data/usecases/movie_usecase/get_watchlist_movies.dart';
import 'package:tmdb_movies_app/data/usecases/movie_usecase/get_watchlist_status.dart';
import 'package:tmdb_movies_app/data/usecases/movie_usecase/remove_watchlist.dart';
import 'package:tmdb_movies_app/data/usecases/movie_usecase/save_watchlist.dart';
import 'package:tmdb_movies_app/data/usecases/movie_usecase/search_movies.dart';
import 'package:http/http.dart' as http;
import 'package:tmdb_movies_app/views/provider/movie_detail_notifier.dart';
import 'package:tmdb_movies_app/views/provider/movie_list_notifier.dart';
import 'package:tmdb_movies_app/views/provider/movie_search_notifier.dart';
import 'package:tmdb_movies_app/views/provider/popular_movies_notifier.dart';
import 'package:tmdb_movies_app/views/provider/top_rated_movies_notifier.dart';
import 'package:tmdb_movies_app/views/provider/watchlist_movies_notifier.dart';

final locator = GetIt.instance;

void init() {
  //provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchlistStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );

  locator.registerFactory(
    () => MovieSearchNotifier(searchMovies: locator()),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(getPopularMovies: locator()),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(getTopRatedMovies: locator()),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(getWatchlistMovies: locator()),
  );

  //use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchlistStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

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
