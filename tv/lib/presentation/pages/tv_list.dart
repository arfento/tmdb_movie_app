import 'package:flutter/material.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/widgets/tv_card_list_horizontal.dart';

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
