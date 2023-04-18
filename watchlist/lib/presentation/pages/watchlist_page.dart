import 'package:core/common/constants.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

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
            indicatorColor: kMikadoYellow,
            tabs: [
              Tab(icon: Icon(EvaIcons.video), text: "Movie"),
              Tab(icon: Icon(EvaIcons.tv), text: "Tv Show"),
            ],
          ),
          title: const Text('Watchlist'),
          leading: IconButton(
            icon: Icon(EvaIcons.arrowBack),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: TabBarView(
          children: [WatchlistMoviesPage(), WatchlistTvsPage()],
        ),
      ),
    );
  }
}
