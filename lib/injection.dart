import 'package:get_it/get_it.dart';
import 'package:local_db/data/datasources/db/database_helper.dart';
import 'package:movie/data/datasources/movie_local_data_source.dart';
import 'package:movie/data/datasources/movie_remote_data_source.dart';
import 'package:movie/data/repositories/movie_repository.dart';
import 'package:movie/data/repositories/movie_repository_impl.dart';
import 'package:movie/domain/usecases/movie_usecase/get_movie_detail.dart';
import 'package:movie/domain/usecases/movie_usecase/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/movie_usecase/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/movie_usecase/get_popular_movies.dart';
import 'package:movie/domain/usecases/movie_usecase/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movie_watchlist_bloc/movie_watchlist_bloc.dart';
import 'package:movie/presentation/bloc/now_playing_movies_bloc/now_playing_movies_bloc.dart';
import 'package:movie/presentation/bloc/popular_movies_bloc/popular_movies_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movies_bloc/top_rated_movies_bloc.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_tvs.dart';
import 'package:search/presentation/bloc/movie_search_bloc/movie_search_bloc.dart';
import 'package:search/presentation/bloc/tv_search_bloc/tv_search_bloc.dart';
import 'package:tmdb_movies_app/common/http_ssl_pinning.dart';
import 'package:tv/data/datasources/tv_local_data_source.dart';
import 'package:tv/data/datasources/tv_remote_data_source.dart';
import 'package:tv/data/repositories/tv_repository.dart';
import 'package:tv/data/repositories/tv_repository_impl.dart';
import 'package:tv/domain/usecases/tv_usecase/get_on_the_air_tvs.dart';
import 'package:tv/domain/usecases/tv_usecase/get_popular_tvs.dart';
import 'package:tv/domain/usecases/tv_usecase/get_top_rated_tvs.dart';
import 'package:tv/domain/usecases/tv_usecase/get_tv_detail.dart';
import 'package:tv/domain/usecases/tv_usecase/get_tv_recommendations.dart';
import 'package:tv/domain/usecases/tv_usecase/get_tv_season.dart';
import 'package:tv/presentation/bloc/on_the_air_tvs_bloc/on_the_air_tvs_bloc.dart';
import 'package:tv/presentation/bloc/popular_tvs_bloc/popular_tvs_bloc.dart';
import 'package:tv/presentation/bloc/top_rated_tvs_bloc/top_rated_tvs_bloc.dart';
import 'package:tv/presentation/bloc/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:tv/presentation/bloc/tv_season_bloc/tv_season_bloc.dart';
import 'package:tv/presentation/bloc/tv_watchlist_bloc/tv_watchlist_bloc.dart';
import 'package:watchlist/domain/usecases/get_watchlist_movies.dart';
import 'package:watchlist/domain/usecases/get_watchlist_status.dart';
import 'package:watchlist/domain/usecases/get_watchlist_tv_status.dart';
import 'package:watchlist/domain/usecases/get_watchlist_tvs.dart';
import 'package:watchlist/domain/usecases/remove_watchlist.dart';
import 'package:watchlist/domain/usecases/remove_watchlist_tv.dart';
import 'package:watchlist/domain/usecases/save_watchlist.dart';
import 'package:watchlist/domain/usecases/save_watchlist_tv.dart';
import 'package:watchlist/presentation/bloc/watchlist_movie_bloc/watchlist_movie_bloc.dart';
import 'package:watchlist/presentation/bloc/watchlist_tv_bloc/watchlist_tv_bloc.dart';

final locator = GetIt.instance;

void init() {
  //bloc
  locator.registerFactory(
    () => MovieDetailBloc(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
    ),
  );

  locator.registerFactory(
    () => MovieSearchBloc(locator()),
  );
  locator.registerFactory(
    () => MovieWatchlistBloc(
      getWatchlistStatus: locator(),
      removeWatchlist: locator(),
      saveWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => NowPlayingMoviesBloc(getNowPlayingMovies: locator()),
  );
  locator.registerFactory(
    () => OnTheAirTvsBloc(getOnTheAirTvs: locator()),
  );
  locator.registerFactory(
    () => PopularMoviesBloc(popularMovies: locator()),
  );

  locator.registerFactory(() => PopularTvsBloc(popularTvs: locator()));

  locator.registerFactory(
    () => TopRatedMoviesBloc(topRatedMovies: locator()),
  );
  locator.registerFactory(
    () => TopRatedTvsBloc(topRatedTvs: locator()),
  );
  locator.registerFactory(
    () => TvDetailBloc(
      getTvDetail: locator(),
      getTvRecommendations: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeasonBloc(getTvSeason: locator()),
  );
  locator.registerFactory(
    () => TvSearchBloc(locator()),
  );
  locator.registerFactory(
    () => TvWatchlistBloc(
      getWatchlistStatus: locator(),
      removeWatchlist: locator(),
      saveWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieBloc(watchlistMovies: locator()),
  );
  locator.registerFactory(
    () => WatchlistTvBloc(watchlistTvs: locator()),
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

  // use case tv show
  locator.registerLazySingleton(() => GetOnTheAirTvs(locator()));
  locator.registerLazySingleton(() => GetPopularTvs(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvs(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvs(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvs(locator()));
  locator.registerLazySingleton(() => GetTvSeason(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data source
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovielocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helpers
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  // locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
