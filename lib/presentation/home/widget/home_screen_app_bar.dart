import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uponorflix/presentation/home/bloc/movie_bloc.dart';
import 'package:uponorflix/presentation/home/widget/filters_row.dart';
import 'package:uponorflix/presentation/settings/settings_screen.dart';

// TODO Refactor
class HomeScreenAppBar extends StatelessWidget {
  const HomeScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        return SliverAppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          expandedHeight: 220,
          floating: true,
          snap: true,
          pinned: true,
          stretch: true,
          elevation: 0,
          actions: [
            FiltersRow(state: state),
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.white),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                );
              },
            ),
          ],
          flexibleSpace: LayoutBuilder(
            builder: (context, constraints) {
              final isExpanded = constraints.maxHeight > kToolbarHeight + 40;
              return FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(
                  left: 32,
                  bottom: 32,
                  right: 60,
                ),
                title: isExpanded
                    ? Text(
                        'UponorFlix',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 8,
                              color: Colors.black54,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset('assets/sliver_bg.avif', fit: BoxFit.cover),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withAlpha(60),
                            Theme.of(
                              context,
                            ).colorScheme.primary.withAlpha(170),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
