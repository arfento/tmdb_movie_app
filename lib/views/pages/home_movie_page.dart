import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_movies_app/common/constants.dart';
import 'package:tmdb_movies_app/common/state_enum.dart';
import 'package:tmdb_movies_app/views/pages/about_page.dart';
import 'package:tmdb_movies_app/views/pages/movie_list.dart';
import 'package:tmdb_movies_app/views/pages/popular_movies_page.dart';
import 'package:tmdb_movies_app/views/pages/search_page.dart';
import 'package:tmdb_movies_app/views/pages/top_rated_movies_page.dart';
import 'package:tmdb_movies_app/views/pages/watchlist_movies_page.dart';
import 'package:tmdb_movies_app/views/provider/movie_provider/movie_list_notifier.dart';
import 'package:tmdb_movies_app/views/widgets/custom_drawer.dart';

class HomeMoviePage extends StatefulWidget {
  static const ROUTE_NAME = '/home';
  const HomeMoviePage({Key? key}) : super(key: key);

  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<MovieListNotifier>(context, listen: false)
        ..fetchNowPlayingMovies()
        ..fetchPopularMovies()
        ..fetchTopRatedMovies(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('My Movies'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, SearchPage.ROUTE_NAME,
                    arguments: true);
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Now Playing',
              style: kHeading6,
            ),
            Consumer<MovieListNotifier>(
              builder: (context, value, child) {
                final state = value.nowPlayingState;
                if (state == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return MovieList(movies: value.nowPlayingMovies);
                } else {
                  return const Center(
                    child: Text('Failed'),
                  );
                }
              },
            ),
            _buildSubHeading(
              title: "Popular",
              onTap: () {
                Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME);
              },
            ),
            Consumer<MovieListNotifier>(
              builder: (context, value, child) {
                final state = value.popularState;
                if (state == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return MovieList(movies: value.popularMovies);
                } else {
                  return const Center(
                    child: Text('Failed'),
                  );
                }
              },
            ),
            _buildSubHeading(
              title: "Top Rated",
              onTap: () {
                Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME);
              },
            ),
            Consumer<MovieListNotifier>(
              builder: (context, value, child) {
                final state = value.topRatedMoviesState;
                if (state == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return MovieList(movies: value.topRatedMovies);
                } else {
                  return const Center(
                    child: Text('Failed'),
                  );
                }
              },
            ),
          ],
        )),
      ),
    );
  }

  _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: const <Widget>[
                Text('See More'),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        )
      ],
    );
  }
}
