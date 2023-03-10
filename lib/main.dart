import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_movies_app/common/constants.dart';
import 'package:tmdb_movies_app/common/utils.dart';
import 'package:tmdb_movies_app/data/models/entities/movie_detail.dart';
import 'package:tmdb_movies_app/views/pages/about_page.dart';
import 'package:tmdb_movies_app/views/pages/home_movie_page.dart';
import 'package:tmdb_movies_app/views/pages/movie_detail_page.dart';
import 'package:tmdb_movies_app/views/pages/popular_movies_page.dart';
import 'package:tmdb_movies_app/views/pages/search_page.dart';
import 'package:tmdb_movies_app/views/pages/top_rated_movies_page.dart';
import 'package:tmdb_movies_app/views/pages/watchlist_movies_page.dart';
import 'package:tmdb_movies_app/views/provider/movie_detail_notifier.dart';
import 'package:tmdb_movies_app/views/provider/movie_list_notifier.dart';
import 'package:tmdb_movies_app/views/provider/movie_search_notifier.dart';
import 'package:tmdb_movies_app/views/provider/watchlist_movies_notifier.dart';
import 'package:tmdb_movies_app/views/provider/top_rated_movies_notifier.dart';
import 'package:tmdb_movies_app/views/provider/popular_movies_notifier.dart';
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
              return CupertinoPageRoute(builder: (_) => const SearchPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
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
