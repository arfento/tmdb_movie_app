import 'watchlist_movies_page.dart';
import 'package:flutter/material.dart';

import 'watchlist_tvs_page.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';
  const WatchlistPage({Key? key}) : super(key: key);

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.movie), text: "Movie"),
              Tab(icon: Icon(Icons.live_tv_rounded), text: "Tv Show"),
            ],
          ),
          title: const Text('Watchlist'),
        ),
        body: TabBarView(
          children: [WatchlistMoviesPage(), WatchlistTvsPage()],
        ),
      ),
    );
  }
}
