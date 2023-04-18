import 'package:core/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';
import 'package:watchlist/presentation/bloc/watchlist_tv_bloc/watchlist_tv_bloc.dart';

class WatchlistTvsPage extends StatefulWidget {
  @override
  _WatchlistTvsPageState createState() => _WatchlistTvsPageState();
}

class _WatchlistTvsPageState extends State<WatchlistTvsPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<WatchlistTvBloc>()..add(FetchWatchlistTv()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Future.microtask(
        () => context.read<WatchlistTvBloc>()..add(FetchWatchlistTv()));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
        builder: (context, state) {
          if (state is WatchlistTvLoading) {
            return const Center(
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
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return const Center(
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
