import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/now_playing_movies_bloc/now_playing_movies_bloc.dart';
import 'package:movie/presentation/bloc/popular_movies_bloc/popular_movies_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movies_bloc/top_rated_movies_bloc.dart';
import 'package:movie/presentation/pages/movie_list.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<NowPlayingMoviesBloc>(context, listen: false)
          .add(FetchNowPlayingMovies());
      BlocProvider.of<TopRatedMoviesBloc>(context, listen: false)
          .add(FetchTopRatedMovies());
      BlocProvider.of<PopularMoviesBloc>(context, listen: false)
          .add(FetchPopularMovies());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Now Playing',
              style: kHeading6,
            ),
          ),
          BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
            builder: (context, state) {
              if (state is NowPlayingMovieLoading) {
                return const SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is NowPlayingMovieHasData) {
                return MovieList(movies: state.listMovie);
              } else {
                return const SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Center(child: Text("Failed")),
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
          BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
            builder: (context, state) {
              if (state is PopularMoviesLoading) {
                return const SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is PopularMoviesHasData) {
                return MovieList(movies: state.listMovie);
              } else {
                return const SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Center(child: Text("Failed")),
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
          BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
            builder: (context, state) {
              if (state is TopRatedMoviesLoading) {
                return const SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is TopRatedMoviesHasData) {
                return MovieList(movies: state.listMovie);
              } else {
                return const SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Center(child: Text("Failed")),
                );
              }
            },
          ),
        ],
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
