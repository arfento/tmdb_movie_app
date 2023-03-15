import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_movies_app/common/constants.dart';
import 'package:tmdb_movies_app/common/utils.dart';
import 'package:tmdb_movies_app/views/pages/about_page.dart';
import 'package:tmdb_movies_app/views/pages/home_movie_page.dart';
import 'package:tmdb_movies_app/views/pages/home_tv_page.dart';
import 'package:tmdb_movies_app/views/pages/movie_detail_page.dart';
import 'package:tmdb_movies_app/views/pages/on_the_air_tvs_page.dart';
import 'package:tmdb_movies_app/views/pages/popular_movies_page.dart';
import 'package:tmdb_movies_app/views/pages/popular_tvs_page.dart';
import 'package:tmdb_movies_app/views/pages/search_page.dart';
import 'package:tmdb_movies_app/views/pages/top_rated_movies_page.dart';
import 'package:tmdb_movies_app/views/pages/top_rated_tvs_page.dart';
import 'package:tmdb_movies_app/views/pages/tv_detail_page.dart';
import 'package:tmdb_movies_app/views/pages/tv_season_page.dart';
import 'package:tmdb_movies_app/views/pages/watchlist_movies_page.dart';
import 'package:tmdb_movies_app/views/provider/movie_provider/movie_detail_notifier.dart';
import 'package:tmdb_movies_app/views/provider/movie_provider/movie_list_notifier.dart';
import 'package:tmdb_movies_app/views/provider/movie_provider/movie_search_notifier.dart';
import 'package:tmdb_movies_app/views/provider/movie_provider/popular_movies_notifier.dart';
import 'package:tmdb_movies_app/views/provider/movie_provider/top_rated_movies_notifier.dart';
import 'package:tmdb_movies_app/views/provider/movie_provider/watchlist_movies_notifier.dart';
import 'package:tmdb_movies_app/views/provider/tv_provider/on_the_air_tvs_notifier.dart';
import 'package:tmdb_movies_app/views/provider/tv_provider/popular_tvs_notifier.dart';
import 'package:tmdb_movies_app/views/provider/tv_provider/top_rated_tvs_notifier.dart';
import 'package:tmdb_movies_app/views/provider/tv_provider/tv_detail_notifier.dart';
import 'package:tmdb_movies_app/views/provider/tv_provider/tv_list_notifier.dart';
import 'package:tmdb_movies_app/views/provider/tv_provider/tv_search_notifier.dart';
import 'package:tmdb_movies_app/views/provider/tv_provider/tv_season_notifier.dart';
import 'package:tmdb_movies_app/views/provider/tv_provider/watchlist_tv_notifier.dart';
import 'injection.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MovieListNotifier>(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider<TopRatedMoviesNotifier>(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider<PopularMoviesNotifier>(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider<WatchlistMovieNotifier>(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider<MovieDetailNotifier>(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider<MovieSearchNotifier>(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider<TvListNotifier>(
          create: (_) => di.locator<TvListNotifier>(),
        ),
        ChangeNotifierProvider<OnTheAirTvsNotifier>(
          create: (_) => di.locator<OnTheAirTvsNotifier>(),
        ),
        ChangeNotifierProvider<PopularTvsNotifier>(
          create: (_) => di.locator<PopularTvsNotifier>(),
        ),
        ChangeNotifierProvider<TopRatedTvsNotifier>(
          create: (_) => di.locator<TopRatedTvsNotifier>(),
        ),
        ChangeNotifierProvider<TvDetailNotifier>(
          create: (_) => di.locator<TvDetailNotifier>(),
        ),
        ChangeNotifierProvider<TvSearchNotifier>(
          create: (_) => di.locator<TvSearchNotifier>(),
        ),
        ChangeNotifierProvider<WatchlistTvNotifier>(
          create: (_) => di.locator<WatchlistTvNotifier>(),
        ),
        ChangeNotifierProvider<TvSeasonNotifier>(
          create: (_) => di.locator<TvSeasonNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: const HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => const HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const TopRatedMoviesPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const WatchlistMoviesPage());
            case SearchPage.ROUTE_NAME:
              final isMovie = settings.arguments as bool;
              return CupertinoPageRoute(
                  builder: (_) => SearchPage(
                        isMovie: isMovie,
                      ));
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case HomeTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => HomeTvPage());
            case TvDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case OnTheAirTvsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => OnTheAirTvsPage());
            case PopularTvsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvsPage());
            case TopRatedTvsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvsPage());
            case TvSeasonPage.ROUTE_NAME:
              TvSeasonArguments arguments =
                  settings.arguments as TvSeasonArguments;
              return CupertinoPageRoute(
                  builder: (_) => TvSeasonPage(
                        id: arguments.id,
                        seasonNumber: arguments.seasonNumber,
                      ));

            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
