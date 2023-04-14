import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_movies_app/common/constants.dart';
import 'package:tmdb_movies_app/domain/entities/tv.dart';
import 'package:tmdb_movies_app/views/pages/tv_detail_page.dart';

class TvCardListHorizontal extends StatelessWidget {
  final Tv tv;
  const TvCardListHorizontal({
    Key? key,
    required this.tv,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 110,
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            TvDetailPage.ROUTE_NAME,
            arguments: tv.id,
          );
        },
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
            placeholder: (context, url) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
