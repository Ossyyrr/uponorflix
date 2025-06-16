import 'package:flutter/material.dart';
import 'package:uponorflix/core/model/movie.dart';
import 'package:uponorflix/layout/home/widget/movie_list_tile.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;
  final void Function(Movie) onEdit;
  final void Function(Movie) onDelete;
  final void Function(Movie) onTap;

  const MovieList({
    super.key,
    required this.movies,
    required this.onEdit,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final crossAxisCount = isLandscape ? 2 : 1;

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) {
          final movie = movies[index];
          return MovieListTile(
            movie: movie,
            onEdit: () => onEdit(movie),
            onDelete: () => onDelete(movie),
            onTap: () => onTap(movie),
          );
        }, childCount: movies.length),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 1.7,
        ),
      ),
    );
  }
}
