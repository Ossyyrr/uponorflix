import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uponorflix/presentation/home/bloc/movie_bloc.dart';
import 'package:uponorflix/presentation/home/widget/add_movie_button.dart';
import 'package:uponorflix/presentation/home/widget/category_section.dart';
import 'package:uponorflix/presentation/home/widget/home_carousel.dart';
import 'package:uponorflix/presentation/home/widget/home_screen_app_bar.dart';
import 'package:uponorflix/presentation/home/widget/movie_list.dart';
import 'package:uponorflix/presentation/utils/enum/screen_status.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          return state.status.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: () => Center(child: Text(state.errorMessage ?? 'Error')),
            success: () {
              return CustomScrollView(
                slivers: [
                  HomeScreenAppBar(),
                  const SliverToBoxAdapter(child: SizedBox(height: 32)),
                  HomeCarousel(),
                  const SliverToBoxAdapter(child: SizedBox(height: 16)),
                  if (state.filteredMovies.isEmpty)
                    const SliverToBoxAdapter(
                      child: Center(child: Text('No hay películas')),
                    )
                  else
                    for (final entry
                        in state.filteredMoviesByCategory.entries) ...[
                      CategorySection(entry: entry),
                      MovieList(movies: entry.value),
                    ],
                  const SliverToBoxAdapter(child: SizedBox(height: 32)),
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
