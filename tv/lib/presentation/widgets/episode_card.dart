import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tv/presentation/pages/tv_season_page.dart';

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
        margin: const EdgeInsets.only(right: 8),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: CachedNetworkImage(
                    imageUrl: 'https://image.tmdb.org/t/p/w300${eps.stillPath}',
                    width: 180,
                    height: 100,
                    maxHeightDiskCache: 100,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Container(
                  width: 180,
                  height: 100,
                  padding: const EdgeInsets.all(6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Eps ${eps.episodeNumber}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        eps.name,
                        style: const TextStyle(fontSize: 10, height: 1),
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
