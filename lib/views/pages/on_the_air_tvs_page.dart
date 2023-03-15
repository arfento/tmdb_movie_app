import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_movies_app/common/state_enum.dart';
import 'package:tmdb_movies_app/views/provider/tv_provider/on_the_air_tvs_notifier.dart';
import 'package:tmdb_movies_app/views/widgets/tv_card_list.dart';

class OnTheAirTvsPage extends StatefulWidget {
  static const ROUTE_NAME = '/on-the-air-tvs';
  const OnTheAirTvsPage({Key? key}) : super(key: key);

  @override
  _OnTheAirTvsPageState createState() => _OnTheAirTvsPageState();
}

class _OnTheAirTvsPageState extends State<OnTheAirTvsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<OnTheAirTvsNotifier>(context, listen: false)
            .fetchOnTheAirTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On The Air Tv Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<OnTheAirTvsNotifier>(
          builder: (context, value, child) {
            final state = value.state;
            if (state == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = value.tvs[index];
                  return TvCard(tv);
                },
                itemCount: value.tvs.length,
              );
            } else {
              return Center(
                key: const Key('error_message'), // key to test app
                child: Text(value.message),
              );
            }
          },
        ),
      ),
    );
  }
}
