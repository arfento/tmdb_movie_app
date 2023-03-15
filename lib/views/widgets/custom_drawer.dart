import 'package:flutter/material.dart';
import 'package:tmdb_movies_app/views/pages/home_tv_page.dart';
import 'package:tmdb_movies_app/views/pages/watchlist_movies_page.dart';

import '../pages/about_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/circle-g.png'),
            ),
            accountName: Text("My Movies"),
            accountEmail: Text("arfento@gmail.com"),
          ),
          ListTile(
            leading: const Icon(Icons.movie),
            title: const Text("Movies"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.live_tv),
            title: const Text('Tv Shows'),
            onTap: () {
              Navigator.pushNamed(context, HomeTvPage.ROUTE_NAME);
            },
          ),
          ListTile(
            leading: const Icon(Icons.save_alt),
            title: const Text("Watchlist"),
            onTap: () {
              Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
            },
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
            },
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
          ),
        ],
      ),
    );
  }
}
