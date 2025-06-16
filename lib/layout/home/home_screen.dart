import 'package:flutter/material.dart';
import 'package:uponorflix/core/model/movie.dart';
import 'package:uponorflix/data/service/firestore_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirestoreService _firestoreService = FirestoreService();

  void _addTestMovie() async {
    final movie = Movie(
      title: 'Nueva Película',
      description: 'Descripción de ejemplo',
      imageUrl:
          'https://ih1.redbubble.net/image.4598241582.6557/st,small,507x507-pad,600x600,f8f8f8.jpg',
    );
    await _firestoreService.addMovie(movie);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
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
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return ListTile(
                leading: movie.imageUrl.isNotEmpty
                    ? Image.network(
                        movie.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                    : const Icon(Icons.movie),
                title: Text(movie.title),
                subtitle: Text(movie.description),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _firestoreService.deleteMovie(movie.id),
                ),
                onTap: () {
                  // TODO go edit movie
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTestMovie,
        tooltip: 'Agregar película',
        child: const Icon(Icons.add),
      ),
    );
  }
}
