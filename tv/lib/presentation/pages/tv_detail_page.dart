import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';
import 'package:tv/presentation/bloc/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:tv/presentation/bloc/tv_watchlist_bloc/tv_watchlist_bloc.dart';
import 'package:tv/presentation/widgets/season_content.dart';
import 'package:tv/presentation/widgets/tv_card_list_horizontal.dart';
import '../../domain/entities/genre.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/tv.dart';
import '../../domain/entities/tv_detail.dart';

class TvDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv';

  final int id;
  const TvDetailPage({super.key, required this.id});

  @override
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<TvDetailBloc>(listen: false, context)
          .add(FetchTvDetail(widget.id));
      BlocProvider.of<TvWatchlistBloc>(context, listen: false)
          .add(LoadWatchlistStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isAddedToWatchList = context.select<TvWatchlistBloc, bool>(
        (watchlistBloc) => (watchlistBloc.state is SuccessLoadWatchlist)
            ? (watchlistBloc.state as SuccessLoadWatchlist).isAddedToWatchlist
            : false);
    return Scaffold(
      body: BlocListener<TvWatchlistBloc, TvWatchlistState>(
        listener: (context, state) {
          if (state is SuccessAddOrRemoveWatchlist) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: kMikadoYellow,
              duration: const Duration(seconds: 1),
            ));
          } else if (state is FailedAddOrRemoveWatchlist) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              duration: const Duration(seconds: 1),
            ));
          }
        },
        child: BlocBuilder<TvDetailBloc, TvDetailState>(
          builder: (context, state) {
            if (state is TvDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvDetailHasData) {
              return SafeArea(
                child: DetailContent(
                  state.tvDetail,
                  state.tvRecommendations,
                  isAddedToWatchList,
                ),
              );
            } else {
              return const Center(child: Text("Failed"));
            }
          },
        ),
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvDetail tv;
  final List<Tv> recommendations;
  final bool isAddedWatchlist;

  const DetailContent(this.tv, this.recommendations, this.isAddedWatchlist,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(EvaIcons.arrowBack)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 16.0, top: 8, bottom: 8, left: 8),
                child: Text(
                  tv.name,
                  maxLines: 2,
                  style: kHeading5,
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        'https://image.tmdb.org/t/p/w400${(tv.backdropPath != null) ? tv.backdropPath : tv.posterPath}',
                    width: screenWidth,
                    height: 200,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Container(
                    width: screenWidth,
                    height: 200,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [kRichBlack, Colors.transparent],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter)),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(top: 140, left: 16, right: 16),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                            width: 80,
                            height: 120,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(top: 200 - 160),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _showYear(tv.firstAirDate),
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                                Text(
                                  tv.name,
                                  style: kHeading6,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    RatingBarIndicator(
                                      rating: tv.voteAverage / 2,
                                      itemCount: 5,
                                      itemBuilder: (context, index) =>
                                          const Icon(
                                        Icons.star,
                                        color: kMikadoYellow,
                                      ),
                                      itemSize: 18,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      '${tv.voteAverage}',
                                      style:
                                          const TextStyle(color: kMikadoYellow),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: InkWell(
                  onTap: () async {
                    if (!isAddedWatchlist) {
                      BlocProvider.of<TvWatchlistBloc>(context, listen: false)
                          .add(AddToWatchlist(tv));
                    } else {
                      BlocProvider.of<TvWatchlistBloc>(context, listen: false)
                          .add(RemoveFromWatchList(tv));
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8), color: kGrey),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        isAddedWatchlist
                            ? const Icon(
                                EvaIcons.checkmark,
                                size: 16,
                                color: kMikadoYellow,
                              )
                            : const Icon(
                                EvaIcons.plus,
                                size: 16,
                                color: kWhite,
                              ),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text('Watchlist'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Genre',
                  style: kSubtitle,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 25,
                child: ListView(
                  padding: const EdgeInsets.only(left: 16),
                  scrollDirection: Axis.horizontal,
                  children: tv.genres
                      .map(
                        (genre) => Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(width: 1, color: kGrey),
                              color: kRichBlack),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          margin: const EdgeInsets.only(right: 6),
                          child: Center(
                            child: Text(
                              genre.name,
                              style: const TextStyle(fontSize: 12, height: 1),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Description',
                  style: kSubtitle,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ReadMoreText(
                  tv.overview,
                  trimLines: 3,
                  trimMode: TrimMode.Line,
                  colorClickableText: kWhite,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  (tv.seasons.length == 1) ? 'Season 1' : 'Seasons',
                  style: kSubtitle,
                ),
              ),
              SeasonContent(tv),
              const SizedBox(
                height: 16,
              ),
              (recommendations.isEmpty)
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Similar Movies',
                        style: kSubtitle,
                      ),
                    ),
              const SizedBox(
                height: 8,
              ),
              (recommendations.isEmpty)
                  ? Container()
                  : SizedBox(
                      height: 150,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(left: 16),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final tv = recommendations[index];
                          return TvCardListHorizontal(tv: tv);
                        },
                        itemCount: recommendations.length,
                      ),
                    ),
              const SizedBox(
                height: 16,
              ),
            ]),
          ),
        ),
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showYear(String? date) {
    final String year = date == null ? "" : date.substring(0, 4);
    return year;
  }
}
