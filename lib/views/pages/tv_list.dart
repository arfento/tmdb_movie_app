import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_movies_app/common/constants.dart';
import 'package:tmdb_movies_app/domain/entities/tv.dart';
import 'package:tmdb_movies_app/views/pages/tv_detail_page.dart';
import 'package:tmdb_movies_app/views/widgets/tv_card_list_horizontal.dart';

class TvList extends StatelessWidget {
  final List<Tv>? tvs;
  const TvList({Key? key, required this.tvs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 8),
        scrollDirection: Axis.horizontal,
        itemCount: tvs!.length,
        itemBuilder: (context, index) {
          final tv = tvs![index];
          return TvCardListHorizontal(tv: tv);
        },
      ),
    );
  }
}
