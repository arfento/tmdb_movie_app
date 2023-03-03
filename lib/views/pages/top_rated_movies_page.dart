import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_movies_app/common/state_enum.dart';
import 'package:tmdb_movies_app/views/provider/top_rated_movies_notifier.dart';
import 'package:tmdb_movies_app/views/widgets/movie_card_list.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';
  const TopRatedMoviesPage({Key? key}) : super(key: key);

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TopRatedMoviesNotifier>(context, listen: false)
            .fetchTopRatedMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TopRatedMoviesNotifier>(
          builder: (context, value, child) {
            final state = value.state;
            if (state == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = value.movies[index];
                  return MovieCard(movie);
                },
                itemCount: value.movies.length,
              );
            } else {
              return Center(
                key: const Key('error_message'), // key to test app
                child: Text(value.message),
              );
            }
          },
        ),
      ),
    );
  }
}
