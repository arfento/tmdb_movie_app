import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movies_bloc/top_rated_movies_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:provider/provider.dart';

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
        Provider.of<TopRatedMoviesBloc>(context, listen: false)
            .add(FetchTopRatedMovies()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
          builder: (context, state) {
            if (state is TopRatedMoviesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedMoviesHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.listMovie[index];
                  return MovieCard(movie);
                },
                itemCount: state.listMovie.length,
              );
            } else if (state is TopRatedMoviesError) {
              return Center(
                key: const Key('error_message'), // key to test app
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text("Failed"),
              );
            }
          },
        ),
      ),
    );
  }
}
