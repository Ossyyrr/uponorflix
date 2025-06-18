import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uponorflix/domain/model/movie.dart';
import 'package:uponorflix/presentation/detail/detail_screen.dart';
import 'package:uponorflix/presentation/home/bloc/movie_bloc.dart';
import 'package:uponorflix/presentation/home/widget/movie_list_tile.dart';
import 'package:uponorflix/presentation/movieForm/movie_form_screen.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: movies.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final movie = movies[index];
            return SizedBox(
              width: 320,
              child: MovieListTile(
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
                    MaterialPageRoute(
                      builder: (_) => DetailScreen(movie: movie),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
