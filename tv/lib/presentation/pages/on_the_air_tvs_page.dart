import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/on_the_air_tvs_bloc/on_the_air_tvs_bloc.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';

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
        BlocProvider.of<OnTheAirTvsBloc>(context, listen: false)
            .add(FetchOnTheAirTvs()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On The Air Tv Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<OnTheAirTvsBloc, OnTheAirTvsState>(
          builder: (context, state) {
            if (state is OnTheAirTvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is OnTheAirTvHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.listTv[index];
                  return TvCard(tv);
                },
                itemCount: state.listTv.length,
              );
            } else if (state is OnTheAirTvError) {
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
