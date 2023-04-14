import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_movies_app/views/pages/tv_season_page.dart';

import '../../common/constants.dart';
import '../../domain/entities/episode.dart';

class EpisodeCard extends StatelessWidget {
  const EpisodeCard({
    Key? key,
    required this.eps,
  }) : super(key: key);

  final Episode eps;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return TvSeasonPage(id: eps.id, seasonNumber: eps.episodeNumber);
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 8),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: 'https://image.tmdb.org/t/p/w300${eps.stillPath}',
                    width: 180,
                    height: 100,
                    maxHeightDiskCache: 100,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                Container(
                  width: 180,
                  height: 100,
                  padding: EdgeInsets.all(6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Eps ${eps.episodeNumber}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        eps.name,
                        style: TextStyle(fontSize: 10, height: 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
