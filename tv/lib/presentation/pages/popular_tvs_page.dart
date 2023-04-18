import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/popular_tvs_bloc/popular_tvs_bloc.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';

class PopularTvsPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tvs';
  const PopularTvsPage({Key? key}) : super(key: key);

  @override
  _PopularTvsPageState createState() => _PopularTvsPageState();
}

class _PopularTvsPageState extends State<PopularTvsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<PopularTvsBloc>(context, listen: false)
            .add(FetchPopularTvs()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tv Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvsBloc, PopularTvsState>(
          builder: (context, state) {
            if (state is PopularTvsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTvsHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.listTv[index];
                  return TvCard(tv);
                },
                itemCount: state.listTv.length,
              );
            } else if (state is PopularTvsError) {
              return Center(
                key: const Key('error_message'), // key to test app
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text("Failed"),
              );
            }
          },
        ),
      ),
    );
  }
}
