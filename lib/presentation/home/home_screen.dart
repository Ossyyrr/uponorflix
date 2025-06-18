import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uponorflix/domain/model/movie.dart';
import 'package:uponorflix/presentation/home/bloc/home_bloc.dart';
import 'package:uponorflix/presentation/home/widget/add_movie_button.dart';
import 'package:uponorflix/presentation/home/widget/home_screen_app_bar.dart';
import 'package:uponorflix/presentation/home/widget/movie_list.dart';
import 'package:uponorflix/presentation/utils/enum/screen_status.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieBloc, MovieState>(
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
                  MovieList(movies: state.movies, title: title),
                  // CategorySection(
                  //   title: 'drama',
                  //   movies: state.movies
                  //       .where((m) => m.category == 'drama')
                  //       .toList(),
                  // ),
                  // CategorySection(
                  //   title: 'comedia',
                  //   movies: state.movies
                  //       .where((m) => m.category == 'comedia')
                  //       .toList(),
                  // ),
                  // CategorySection(
                  //   title: 'Todas las Películas',
                  //   movies: state.movies,
                  // ),
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: AddMovieButton(),
    );
  }
}

class CategorySection extends StatelessWidget {
  final String title;
  final List<Movie> movies;

  const CategorySection({super.key, required this.title, required this.movies});

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) return const SizedBox.shrink();
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 240,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: movies.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final movie = movies[index];
                return SizedBox(
                  width: 160,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: movie.imageUrl.isNotEmpty
                              ? Image.network(movie.imageUrl, fit: BoxFit.cover)
                              : Container(color: Colors.grey[300]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            movie.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
