import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uponorflix/domain/model/movie.dart';
import 'package:uponorflix/presentation/home/bloc/movie_bloc.dart';
import 'package:uponorflix/presentation/movieForm/movie_form_screen.dart';

class AddMovieButton extends StatelessWidget {
  const AddMovieButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        final movie = await Navigator.of(context).push<Movie>(
          MaterialPageRoute(builder: (_) => const MovieFormScreen()),
        );
        if (movie != null) {
          context.read<MovieBloc>().add(AddMovie(movie));
        }
      },
      tooltip: 'Agregar película',
      child: const Icon(Icons.add),
    );
  }
}
