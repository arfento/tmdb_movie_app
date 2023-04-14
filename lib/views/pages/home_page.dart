import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_movies_app/common/constants.dart';
import 'package:tmdb_movies_app/views/pages/search_page.dart';
import 'package:tmdb_movies_app/views/pages/watchlist_page.dart';

import 'about_page.dart';
import 'movie_page.dart';
import 'tv_page.dart';

class HomePage extends StatefulWidget {
  static const ROUTE_NAME = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectIndex = 0;
  final _page = [
    MoviePage(),
    TvPage(),
    null,
    AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              EvaIcons.video,
            ),
            label: 'Movie',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              EvaIcons.tv,
            ),
            label: 'Tv Shows',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              EvaIcons.bookmark,
            ),
            label: 'Watchlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              EvaIcons.info,
            ),
            label: 'About',
          ),
        ],
        currentIndex: _selectIndex,
        onTap: (index) {
          if (index == 2) {
            Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
          } else {
            setState(() {
              _selectIndex = index;
            });
          }
        },
        backgroundColor: kRichBlack,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kWhite,
        unselectedFontSize: 11,
        iconSize: 22,
        selectedFontSize: 11,
        unselectedItemColor: kDavysGrey,
        elevation: 1,
      ),
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              EvaIcons.film,
              color: kMikadoYellow,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              "TMDB MOVIES",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kMikadoYellow,
                fontSize: 19,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
            },
            icon: Icon(
              EvaIcons.search,
              color: kWhite,
            ),
          )
        ],
      ),
      body: _page[_selectIndex],
    );
  }
}
