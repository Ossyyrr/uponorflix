import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uponorflix/domain/model/movie.dart';
import 'package:uponorflix/presentation/home/bloc/home_bloc.dart';
import 'package:uponorflix/presentation/home/widget/home_screen_app_bar.dart';
import 'package:uponorflix/presentation/home/widget/movie_list.dart';
import 'package:uponorflix/presentation/movieFormScreen/movie_form_screen.dart';
import 'package:uponorflix/presentation/utils/enum/screen_status.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return state.status.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: () => Center(child: Text(state.errorMessage ?? 'Error')),
            success: () {
              if (state.movies.isEmpty) {
                return const Center(child: Text('No hay películas'));
              }
              return CustomScrollView(
                slivers: [
                  HomeScreenAppBar(title: title),
                  MovieList(
                    movies: state.movies,
                    onEdit: (movie) async {
                      final updatedMovie = await Navigator.of(context)
                          .push<Movie>(
                            MaterialPageRoute(
                              builder: (_) => MovieFormScreen(movie: movie),
                            ),
                          );
                      if (updatedMovie != null) {
                        context.read<HomeBloc>().add(UpdateMovie(updatedMovie));
                      }
                    },
                    onDelete: (movie) {
                      context.read<HomeBloc>().add(DeleteMovie(movie.id));
                    },
                    onTap: (movie) {
                      // TODO: go detail movie (Youtube video)
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () async {
            final movie = await Navigator.of(context).push<Movie>(
              MaterialPageRoute(builder: (_) => const MovieFormScreen()),
            );
            if (movie != null) {
              context.read<HomeBloc>().add(AddMovie(movie));
            }
          },
          tooltip: 'Agregar película',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
