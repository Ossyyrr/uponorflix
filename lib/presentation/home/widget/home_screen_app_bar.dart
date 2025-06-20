import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uponorflix/presentation/home/bloc/movie_bloc.dart';
import 'package:uponorflix/presentation/home/widget/background_home_app_bar.dart';
import 'package:uponorflix/presentation/home/widget/filters_row.dart';
import 'package:uponorflix/presentation/home/widget/settings_button.dart';
import 'package:uponorflix/presentation/home/widget/title_app_bar.dart';

class HomeScreenAppBar extends StatelessWidget {
  const HomeScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        final double expandedHeight =
            MediaQuery.of(context).orientation == Orientation.landscape
            ? 100
            : 220;

        return SliverAppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          expandedHeight: expandedHeight,
          floating: true,
          snap: true,
          pinned: true,
          stretch: true,
          elevation: 0,
          actions: [
            FiltersRow(state: state),
            SettingsButton(),
          ],
          flexibleSpace: LayoutBuilder(
            builder: (context, constraints) {
              final double opacity =
                  ((constraints.maxHeight - (expandedHeight - 50)) /
                          (expandedHeight - (expandedHeight - 50)))
                      .clamp(0.0, 1.0);

              return FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 32, bottom: 32),
                title: Opacity(opacity: opacity, child: TitleAppBar()),
                background: BackgroundHomeAppBar(),
              );
            },
          ),
        );
      },
    );
  }
}
