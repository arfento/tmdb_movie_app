import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_movies_app/views/pages/tv_detail_page.dart';

import '../../common/constants.dart';
import '../../domain/entities/tv.dart';

class TvCard extends StatelessWidget {
  final Tv tv;

  TvCard(this.tv);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          print(tv.id);
          Navigator.pushNamed(
            context,
            TvDetailPage.ROUTE_NAME,
            arguments: tv.id,
          );
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: kDavysGrey, blurRadius: 2)],
                  // border: Border.all(width: 1, color: kWhite),
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [kGrey, kRichBlack])),
              child: Container(
                height: 80,
                margin: const EdgeInsets.only(
                    left: 16 + 110 + 8, bottom: 16, right: 8, top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tv.name ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kSubtitle.copyWith(
                          color: kMikadoYellow, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Text(
                      tv.overview ?? '-',
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
              width: 110,
              height: 130,
              child: CachedNetworkImage(
                imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                imageBuilder: (context, imageProvider) => Container(
                  width: 110,
                  height: 130,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(width: 1, color: kMikadoYellow),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover)),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
