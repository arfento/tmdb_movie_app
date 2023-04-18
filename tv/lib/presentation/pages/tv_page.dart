import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/on_the_air_tvs_bloc/on_the_air_tvs_bloc.dart';
import 'package:tv/presentation/bloc/popular_tvs_bloc/popular_tvs_bloc.dart';
import 'package:tv/presentation/bloc/top_rated_tvs_bloc/top_rated_tvs_bloc.dart';
import 'package:tv/presentation/pages/on_the_air_tvs_page.dart';
import 'package:tv/presentation/pages/popular_tvs_page.dart';
import 'package:tv/presentation/pages/top_rated_tvs_page.dart';
import 'package:tv/presentation/pages/tv_list.dart';

class TvPage extends StatefulWidget {
  const TvPage({Key? key}) : super(key: key);

  @override
  _TvPageState createState() => _TvPageState();
}

class _TvPageState extends State<TvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<OnTheAirTvsBloc>(context, listen: false)
          .add(FetchOnTheAirTvs());
      BlocProvider.of<PopularTvsBloc>(context, listen: false)
          .add(FetchPopularTvs());
      BlocProvider.of<TopRatedTvsBloc>(context, listen: false)
          .add(FetchTopRatedTvs());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSubHeading(
            title: "On The Air",
            onTap: () {
              Navigator.pushNamed(context, OnTheAirTvsPage.ROUTE_NAME);
            },
          ),
          BlocBuilder<OnTheAirTvsBloc, OnTheAirTvsState>(
            builder: (context, state) {
              if (state is OnTheAirTvLoading) {
                return const SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is OnTheAirTvHasData) {
                return TvList(tvs: state.listTv);
              } else {
                return const SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Center(child: Text("Failed")),
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
          BlocBuilder<PopularTvsBloc, PopularTvsState>(
            builder: (context, state) {
              if (state is PopularTvsLoading) {
                return const SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is PopularTvsHasData) {
                return TvList(tvs: state.listTv);
              } else {
                return const SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Center(child: Text("Failed")),
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
          BlocBuilder<TopRatedTvsBloc, TopRatedTvsState>(
            builder: (context, state) {
              if (state is TopRatedTvsLoading) {
                return const SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is TopRatedTvsHasData) {
                return TvList(tvs: state.listTv);
              } else {
                return const SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Center(child: Text("Failed")),
                );
              }
            },
          ),
        ],
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
