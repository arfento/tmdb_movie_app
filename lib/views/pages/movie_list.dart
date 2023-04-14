import 'package:flutter/material.dart';
import 'package:tmdb_movies_app/domain/entities/movie.dart';
import 'package:tmdb_movies_app/views/widgets/movie_card_list_horizontal.dart';

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
