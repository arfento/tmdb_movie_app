import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_movies_app/common/constants.dart';
import 'package:tmdb_movies_app/common/state_enum.dart';
import 'package:tmdb_movies_app/views/pages/on_the_air_tvs_page.dart';
import 'package:tmdb_movies_app/views/pages/popular_tvs_page.dart';
import 'package:tmdb_movies_app/views/pages/search_page.dart';
import 'package:tmdb_movies_app/views/pages/top_rated_tvs_page.dart';
import 'package:tmdb_movies_app/views/pages/tv_list.dart';
import 'package:tmdb_movies_app/views/provider/tv_provider/tv_list_notifier.dart';
import 'package:tmdb_movies_app/views/widgets/custom_drawer.dart';

class HomeTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/home-tv';
  const HomeTvPage({Key? key}) : super(key: key);

  @override
  _HomeTvPageState createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<TvListNotifier>(context, listen: false)
        ..fetchOnTheAirTvs()
        ..fetchPopularTvs()
        ..fetchTopRatedTvs(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tv Show'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, SearchPage.ROUTE_NAME,
                    arguments: false);
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildSubHeading(
              title: "On The Air",
              onTap: () {
                Navigator.pushNamed(context, OnTheAirTvsPage.ROUTE_NAME);
              },
            ),
            Consumer<TvListNotifier>(
              builder: (context, value, child) {
                final state = value.onTheAirState;
                if (state == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TvList(tvs: value.onTheAirTvs);
                } else {
                  return const Center(
                    child: Text('Failed'),
                  );
                }
              },
            ),
            _buildSubHeading(
              title: "Popular",
              onTap: () {
                Navigator.pushNamed(context, PopularTvsPage.ROUTE_NAME);
              },
            ),
            Consumer<TvListNotifier>(
              builder: (context, value, child) {
                final state = value.popularState;
                if (state == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TvList(tvs: value.popularTvs);
                } else {
                  return const Center(
                    child: Text('Failed'),
                  );
                }
              },
            ),
            _buildSubHeading(
              title: "Top Rated",
              onTap: () {
                Navigator.pushNamed(context, TopRatedTvsPage.ROUTE_NAME);
              },
            ),
            Consumer<TvListNotifier>(
              builder: (context, value, child) {
                final state = value.topRatedTvsState;
                if (state == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TvList(tvs: value.topRatedTvs);
                } else {
                  return const Center(
                    child: Text('Failed'),
                  );
                }
              },
            ),
          ],
        )),
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
