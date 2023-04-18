import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';

class MovieCardListHorizontal extends StatelessWidget {
  final Movie movie;
  const MovieCardListHorizontal({
    Key? key,
    required this.movie,
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
            MovieDetailPage.ROUTE_NAME,
            arguments: movie.id,
          );
        },
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
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
