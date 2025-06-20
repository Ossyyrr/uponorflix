import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uponorflix/l10n/app_localizations.dart';
import 'package:uponorflix/presentation/home/bloc/movie_bloc.dart';
import 'package:uponorflix/presentation/home/widget/add_movie_button.dart';
import 'package:uponorflix/presentation/home/widget/category_section.dart';
import 'package:uponorflix/presentation/home/widget/empty_home_message.dart';
import 'package:uponorflix/presentation/home/widget/home_carousel.dart';
import 'package:uponorflix/presentation/home/widget/home_screen_app_bar.dart';
import 'package:uponorflix/presentation/home/widget/movie_list.dart';
import 'package:uponorflix/presentation/home/widget/movie_search_bar.dart';
import 'package:uponorflix/presentation/utils/enum/screen_status.dart';
import 'package:uponorflix/presentation/utils/movie_category_localization.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        body: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            return state.status.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: () => Center(
                child: Text(
                  state.errorMessage ?? AppLocalizations.of(context)!.error,
                ),
              ),
              success: () {
                return CustomScrollView(
                  slivers: [
                    HomeScreenAppBar(),
                    if (state.filteredMovies.isEmpty)
                      EmptyHomeMessage()
                    else ...[
                      const SliverToBoxAdapter(child: SizedBox(height: 32)),
                      CategorySection(
                        text: AppLocalizations.of(context)!.publicFavorites,
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 16)),
                      HomeCarousel(),
                      const SliverToBoxAdapter(child: SizedBox(height: 16)),
                      for (final entry
                          in state.filteredMoviesByCategory.entries) ...[
                        CategorySection(
                          text: getCategoryLabel(context, entry.key),
                        ),
                        MovieList(movies: entry.value),
                      ],
                      const SliverToBoxAdapter(child: SizedBox(height: 32)),
                    ],
                  ],
                );
              },
            );
          },
        ),
        floatingActionButton: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const MovieSearchBar(),
            const SizedBox(width: 16),
            const AddMovieButton(),
          ],
        ),
      ),
    );
  }
}
