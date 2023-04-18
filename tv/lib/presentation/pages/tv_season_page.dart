import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/tv_season_bloc/tv_season_bloc.dart';
import '../../domain/entities/episode.dart';
import 'package:flutter/material.dart';

class TvSeasonPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-season';

  final int id;
  final int seasonNumber;
  const TvSeasonPage({super.key, required this.id, required this.seasonNumber});

  @override
  _TvSeasonPageState createState() => _TvSeasonPageState();
}

class _TvSeasonPageState extends State<TvSeasonPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<TvSeasonBloc>(context, listen: false)
          .add(FetchTvSeason(widget.id, widget.seasonNumber));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Season ${widget.seasonNumber}"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          )),
      body: BlocBuilder<TvSeasonBloc, TvSeasonState>(
        builder: (context, state) {
          if (state is TvSeasonLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvSeasonHasData) {
            final tvSeason = state.tvSeason;
            bool isOnGoing = false;
            final episodes = [];
            for (Episode eps in tvSeason.episodes) {
              if (eps.overview == "" && eps.stillPath == null) {
                isOnGoing = true;
                break;
              }
              episodes.add(eps);
            }
            return SafeArea(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      tvSeason.name != null ? tvSeason.name : "",
                      style: kHeading5,
                    ),
                    ListView.builder(
                      itemCount: episodes.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {
                        return TVEpisodeCard(
                          episode: episodes[index],
                        );
                      }),
                    ),
                    isOnGoing
                        ? Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            padding: const EdgeInsets.all(6),
                            color: Colors.white10,
                            child: Text(
                              "On Going...",
                              style: kSubtitle,
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            ));
          } else if (state is TvSeasonError) {
            return Text(state.messsage);
          } else {
            return const Center(
              child: Text('Failed'),
            );
          }
        },
      ),
    );
  }
}

class TVEpisodeCard extends StatelessWidget {
  final Episode episode;
  const TVEpisodeCard({Key? key, required this.episode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Episode ${episode.episodeNumber}",
            style: kHeading6,
          ),
          Text(
            episode.name,
            style: kSubtitle,
          ),
          CachedNetworkImage(
            imageUrl: 'https://image.tmdb.org/t/p/w300${episode.stillPath}',
            width: screenWidth,
            maxHeightDiskCache: 100,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Text(
            episode.overview,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: kBodyText,
          ),
          const Divider()
        ],
      ),
    );
  }
}

class TvSeasonArguments {
  final int id;
  final int seasonNumber;

  TvSeasonArguments(this.id, this.seasonNumber);
}
