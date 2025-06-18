import 'package:flutter/material.dart';
import 'package:uponorflix/domain/model/movie.dart';
import 'package:uponorflix/presentation/home/widget/movie_list_tile.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 194,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: movies.length,
          separatorBuilder: (_, __) => const SizedBox(),
          itemBuilder: (context, index) {
            final movie = movies[index];
            return SizedBox(width: 320, child: MovieListTile(movie: movie));
          },
        ),
      ),
    );
  }
}
