import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_movies_app/views/bloc/watchlist_tv_bloc/watchlist_tv_bloc.dart';

import '../../common/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/tv_card_list.dart';

class WatchlistTvsPage extends StatefulWidget {
  @override
  _WatchlistTvsPageState createState() => _WatchlistTvsPageState();
}

class _WatchlistTvsPageState extends State<WatchlistTvsPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<WatchlistTvBloc>(context, listen: false)
      ..add(FetchWatchlistTv()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Future.microtask(() => Provider.of<WatchlistTvBloc>(context, listen: false)
      ..add(FetchWatchlistTv()));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
        builder: (context, state) {
          if (state is WatchlistTvLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistTvHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tvShow = state.listTv[index];
                return TvCard(tvShow);
              },
              itemCount: state.listTv.length,
            );
          } else if (state is WatchlistTvError) {
            return Center(
              key: Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return Center(
              key: Key('error_message'),
              child: Text("Failed"),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
