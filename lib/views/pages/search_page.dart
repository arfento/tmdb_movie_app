import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_movies_app/common/constants.dart';
import 'package:tmdb_movies_app/common/state_enum.dart';
import 'package:tmdb_movies_app/views/provider/movie_provider/movie_search_notifier.dart';
import 'package:tmdb_movies_app/views/provider/tv_provider/tv_search_notifier.dart';
import 'package:tmdb_movies_app/views/widgets/movie_card_list.dart';
import 'package:tmdb_movies_app/views/widgets/tv_card_list.dart';

class SearchPage extends StatefulWidget {
  static const ROUTE_NAME = '/search';
  final bool isMovie;
  const SearchPage({Key? key, required this.isMovie}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.isMovie
                ? TextField(
                    onSubmitted: (query) {
                      Provider.of<MovieSearchNotifier>(context, listen: false)
                          .fetchMovieSearch(query);
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search title',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.search,
                  )
                : TextField(
                    onSubmitted: (query) {
                      Provider.of<TvSearchNotifier>(context, listen: false)
                          .fetchTvSearch(query);
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search Tv Show',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.search,
                  ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            widget.isMovie ? _buildMoviesResult() : _buildTvShowsResult()
          ],
        ),
      ),
    );
  }

  Widget _buildMoviesResult() {
    return Consumer<MovieSearchNotifier>(
      builder: (context, data, child) {
        if (data.state == RequestState.Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.state == RequestState.Loaded) {
          final result = data.searchResult;
          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final movie = data.searchResult[index];
                return MovieCard(movie);
              },
              itemCount: result.length,
            ),
          );
        } else {
          return Expanded(
            child: Container(),
          );
        }
      },
    );
  }

  Widget _buildTvShowsResult() {
    return Consumer<TvSearchNotifier>(
      builder: (context, data, child) {
        if (data.state == RequestState.Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.state == RequestState.Loaded) {
          final result = data.searchResult;
          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final tvShow = data.searchResult[index];
                return TvCard(tvShow);
              },
              itemCount: result.length,
            ),
          );
        } else {
          return Expanded(
            child: Container(),
          );
        }
      },
    );
  }
}
