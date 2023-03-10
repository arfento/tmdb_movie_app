import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_movies_app/common/constants.dart';
import 'package:tmdb_movies_app/common/state_enum.dart';
import 'package:tmdb_movies_app/views/provider/movie_search_notifier.dart';
import 'package:tmdb_movies_app/views/widgets/movie_card_list.dart';

class SearchPage extends StatefulWidget {
  static const ROUTE_NAME = '/search';
  const SearchPage({Key? key}) : super(key: key);

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
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (value) {
                Provider.of<MovieSearchNotifier>(context, listen: false)
                    .fetchMovieSearch(value);
              },
              decoration: InputDecoration(
                hintText: "Search Title",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            Consumer<MovieSearchNotifier>(
              builder: (context, value, child) {
                if (value.state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (value.state == RequestState.Loaded) {
                  var result = value.searchResult;
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final movie = result[index];
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
            ),
          ],
        ),
      ),
    );
  }
}
