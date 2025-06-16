import 'package:flutter/material.dart';
import 'package:uponorflix/core/model/movie.dart';
import 'package:uponorflix/data/service/firestore_service.dart';
import 'package:uponorflix/layout/home/widget/home_screen_app_bar.dart';
import 'package:uponorflix/layout/home/widget/movie_list.dart';
import 'package:uponorflix/layout/movieFormScreen/movie_form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Movie>>(
        stream: _firestoreService.getMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay películas'));
          }
          final movies = snapshot.data!;
          return CustomScrollView(
            slivers: [
              HomeScreenAppBar(title: widget.title),
              MovieList(
                movies: movies,
                onEdit: (movie) async {
                  final updatedMovie = await Navigator.of(context).push<Movie>(
                    MaterialPageRoute(
                      builder: (_) => MovieFormScreen(movie: movie),
                    ),
                  );
                  if (updatedMovie != null) {
                    await _firestoreService.updateMovie(updatedMovie);
                  }
                },
                onDelete: (movie) => _firestoreService.deleteMovie(movie.id),
                onTap: (movie) {
                  // TODO go detail movie
                },
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final movie = await Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const MovieFormScreen()));
          if (movie != null && movie is Movie) {
            await _firestoreService.addMovie(movie);
          }
        },
        tooltip: 'Agregar película',
        child: const Icon(Icons.add),
      ),
    );
  }
}
