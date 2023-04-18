import 'package:flutter/material.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/presentation/widgets/movie_card_list_horizontal.dart';

class MovieList extends StatelessWidget {
  final List<Movie>? movies;
  const MovieList({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies!.length,
        itemBuilder: (context, index) {
          final movie = movies![index];
          return MovieCardListHorizontal(movie: movie);
        },
      ),
    );
  }
}
