import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_movies_app/common/utils.dart';
import 'package:tmdb_movies_app/views/bloc/watchlist_movie_bloc/watchlist_movie_bloc.dart';
import 'package:tmdb_movies_app/views/widgets/movie_card_list.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  const WatchlistMoviesPage({Key? key}) : super(key: key);

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WatchlistMovieBloc>(context, listen: false)
            .add(FetchWatchlistMovie()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<WatchlistMovieBloc>(context, listen: false)
        .add(FetchWatchlistMovie());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
        builder: (context, state) {
          if (state is WatchlistMovieLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistMovieHasData) {
            return ListView.builder(
              padding: EdgeInsets.only(top: 8),
              itemBuilder: (context, index) {
                final movie = state.listMovie[index];
                return MovieCard(movie);
              },
              itemCount: state.listMovie.length,
            );
          } else if (state is WatchlistMovieError) {
            return Center(
              key: const Key('error_message'), // key to test app
              child: Text(state.message),
            );
          } else {
            return Center();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
