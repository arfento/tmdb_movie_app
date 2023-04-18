import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  MovieCard(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            MovieDetailPage.ROUTE_NAME,
            arguments: movie.id,
          );
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(color: kDavysGrey, blurRadius: 2)
                  ],
                  // border: Border.all(width: 1, color: kWhite),
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [kGrey, kRichBlack])),
              child: Container(
                height: 80,
                margin: const EdgeInsets.only(
                    left: 16 + 90 + 8, bottom: 16, right: 8, top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      movie.title ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kSubtitle.copyWith(
                          color: kMikadoYellow, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      movie.overview ?? '-',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: kBodyText,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 12,
                bottom: 16,
              ),
              width: 90,
              height: 120,
              child: CachedNetworkImage(
                imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                imageBuilder: (context, imageProvider) => Container(
                  width: 110,
                  height: 130,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(width: 1, color: kMikadoYellow),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover)),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
