import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/presentation/bloc/tv_season_bloc/tv_season_bloc.dart';
import 'package:tv/presentation/widgets/episode_card.dart';

class SeasonContent extends StatefulWidget {
  final TvDetail tv;
  const SeasonContent(this.tv, {super.key});

  @override
  State<SeasonContent> createState() => _SeasonContentState();
}

class _SeasonContentState extends State<SeasonContent> {
  int _selectIndex = 0;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TvSeasonBloc>(context, listen: false)
        .add(FetchTvSeason(widget.tv.id, widget.tv.seasons[0].seasonNumber));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.tv.seasons.length == 1
            ? Container()
            : SizedBox(
                height: 40.0,
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 16),
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.tv.seasons.length,
                  itemBuilder: (BuildContext context, int index) => InkWell(
                    onTap: () {
                      setState(() {
                        _selectIndex = index;
                        BlocProvider.of<TvSeasonBloc>(context, listen: false)
                            .add(FetchTvSeason(widget.tv.id,
                                widget.tv.seasons[index].seasonNumber));
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      height: 40,
                      margin: const EdgeInsets.only(right: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Season ${widget.tv.seasons[index].seasonNumber}',
                            style: TextStyle(
                                color: (_selectIndex == index)
                                    ? kWhite
                                    : kDavysGrey),
                          ),
                          (_selectIndex == index)
                              ? Container(
                                  height: 4,
                                  width: 12,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: kMikadoYellow),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
        const SizedBox(
          height: 8,
        ),
        Container(
          height: 100.0,
          child: BlocBuilder<TvSeasonBloc, TvSeasonState>(
            builder: ((context, state) {
              if (state is TvSeasonLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TvSeasonHasData) {
                List eps = state.tvSeason.episodes
                    .where((e) => e.overview != "" || e.stillPath != null)
                    .toList();
                // final eps = state.tvSeason.episodes;
                return ListView.builder(
                    padding: const EdgeInsets.only(left: 16),
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: eps.length,
                    itemBuilder: (BuildContext context, int index) =>
                        EpisodeCard(eps: eps[index]));
              } else if (state is TvSeasonError) {
                return Text(state.messsage);
              } else {
                return Container();
              }
            }),
          ),
        ),
      ],
    );
  }
}
