import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uponorflix/presentation/detail/detail_screen.dart';
import 'package:uponorflix/presentation/home/bloc/movie_bloc.dart';

class HomeCarousel extends StatelessWidget {
  HomeCarousel({super.key});

  final PageController _controller = PageController(
    viewportFraction: 0.5,
    initialPage: 1,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        double value = 1.0;
        final movies = state.filteredMovies.toList();
        if (movies.isEmpty) const SliverToBoxAdapter(child: SizedBox.shrink());

        return SliverToBoxAdapter(
          child: SizedBox(
            height: MediaQuery.of(context).orientation == Orientation.landscape
                ? 200
                : 100,
            child: PageView.builder(
              controller: _controller,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    value =
                        (_controller.page ?? _controller.initialPage)
                            .toDouble() -
                        index;
                    value = (1 - (value.abs() * 0.3));
                    final borderRadius = BorderRadius.circular(
                      16 + 200 * (1 - value),
                    );
                    return Transform.scale(
                      scale: value,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  DetailScreen(movie: movies[index]),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: borderRadius,
                          child: Image.network(
                            movies[index].imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
