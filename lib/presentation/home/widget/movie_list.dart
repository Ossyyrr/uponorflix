import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uponorflix/domain/model/movie.dart';
import 'package:uponorflix/presentation/detail/detail_screen.dart';
import 'package:uponorflix/presentation/home/bloc/home_bloc.dart';
import 'package:uponorflix/presentation/home/widget/movie_list_tile.dart';
import 'package:uponorflix/presentation/movieForm/movie_form_screen.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;
  final String title;

  const MovieList({super.key, required this.movies, required this.title});

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
            onEdit: () async {
              final updatedMovie = await Navigator.of(context).push<Movie>(
                MaterialPageRoute(
                  builder: (_) => MovieFormScreen(movie: movie),
                ),
              );
              if (updatedMovie != null) {
                context.read<MovieBloc>().add(UpdateMovie(updatedMovie));
              }
            },
            onDelete: () {
              context.read<MovieBloc>().add(DeleteMovie(movie.id));
            },
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => DetailScreen(movie: movie)),
              );
            },
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
