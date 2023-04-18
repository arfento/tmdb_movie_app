import 'package:about/about.dart';
import 'package:core/common/constants.dart';
import 'package:core/common/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movie_watchlist_bloc/movie_watchlist_bloc.dart';
import 'package:movie/presentation/bloc/now_playing_movies_bloc/now_playing_movies_bloc.dart';
import 'package:movie/presentation/bloc/popular_movies_bloc/popular_movies_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movies_bloc/top_rated_movies_bloc.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:search/presentation/bloc/movie_search_bloc/movie_search_bloc.dart';
import 'package:search/presentation/bloc/tv_search_bloc/tv_search_bloc.dart';
import 'package:search/presentation/pages/search_page.dart';
import 'package:tmdb_movies_app/common/http_ssl_pinning.dart';
import 'package:tmdb_movies_app/presentation/pages/home_page.dart';
import 'package:tv/presentation/bloc/on_the_air_tvs_bloc/on_the_air_tvs_bloc.dart';
import 'package:tv/presentation/bloc/popular_tvs_bloc/popular_tvs_bloc.dart';
import 'package:tv/presentation/bloc/top_rated_tvs_bloc/top_rated_tvs_bloc.dart';
import 'package:tv/presentation/bloc/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:tv/presentation/bloc/tv_season_bloc/tv_season_bloc.dart';
import 'package:tv/presentation/bloc/tv_watchlist_bloc/tv_watchlist_bloc.dart';
import 'package:tv/presentation/pages/on_the_air_tvs_page.dart';
import 'package:tv/presentation/pages/popular_tvs_page.dart';
import 'package:tv/presentation/pages/top_rated_tvs_page.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';
import 'package:tv/presentation/pages/tv_season_page.dart';
import 'package:watchlist/presentation/bloc/watchlist_movie_bloc/watchlist_movie_bloc.dart';
import 'package:watchlist/presentation/bloc/watchlist_tv_bloc/watchlist_tv_bloc.dart';
import 'package:watchlist/presentation/pages/watchlist_page.dart';
import 'injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await HttpSSLPinning.init();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<MovieSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieWatchlistBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvWatchlistBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<OnTheAirTvsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeasonBloc>(),
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
        home: const HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const HomePage());
            case WatchlistPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const WatchlistPage());

            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const TopRatedMoviesPage());

            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case TvDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case OnTheAirTvsPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const OnTheAirTvsPage());
            case PopularTvsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => const PopularTvsPage());
            case TopRatedTvsPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const TopRatedTvsPage());
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
