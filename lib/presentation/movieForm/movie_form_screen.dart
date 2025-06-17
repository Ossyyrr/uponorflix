import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uponorflix/data/repository/movie_repository_impl.dart';
import 'package:uponorflix/domain/model/movie.dart';

class MovieFormScreen extends StatefulWidget {
  final Movie? movie;
  const MovieFormScreen({super.key, this.movie});

  @override
  State<MovieFormScreen> createState() => _MovieFormScreenState();
}

class _MovieFormScreenState extends State<MovieFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageUrlController;
  late TextEditingController _trailerUrlController;
  final MovieRepositoryImpl _firestoreService = MovieRepositoryImpl();

  void _addTestMovie() {
    final movie = Movie(
      title: 'Nueva Película',
      description:
          'Descripción de ejemplo Descripción de ejemplo Descripción de ejemplo Descripción de ejemplo Descripción de ejemplo Descripción de ejemplo Descripción de ejemplo Descripción de ejemplo',
      imageUrl:
          'https://ih1.redbubble.net/image.4598241582.6557/st,small,507x507-pad,600x600,f8f8f8.jpg',
      trailerUrl:
          'https://www.youtube.com/watch?v=Ns6ZEpQ1xS0&ab_channel=UniversalSpain',
    );
    _firestoreService.addMovie(movie);
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.movie?.title ?? '');
    _descriptionController = TextEditingController(
      text: widget.movie?.description ?? '',
    );
    _imageUrlController = TextEditingController(
      text: widget.movie?.imageUrl ?? '',
    );
    _trailerUrlController = TextEditingController(
      text: widget.movie?.trailerUrl ?? '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    _trailerUrlController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final movie = Movie(
        id: widget.movie?.id ?? '',
        title: _titleController.text,
        description: _descriptionController.text,
        imageUrl: _imageUrlController.text,
        trailerUrl: _trailerUrlController.text,
      );
      Navigator.of(context).pop(movie);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.movie == null ? 'Nueva Película' : 'Editar Película',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingrese un título' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Ingrese una descripción'
                    : null,
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(
                  labelText: 'URL de la imagen',
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingrese una URL' : null,
              ),
              TextFormField(
                controller: _trailerUrlController,
                decoration: const InputDecoration(
                  labelText: 'Enlace de YouTube (tráiler)',
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Ingrese un enlace de YouTube'
                    : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: _save, child: const Text('Guardar')),
              const SizedBox(height: 12),
              if (kDebugMode)
                ElevatedButton(
                  onPressed: _addTestMovie,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: const Text('Agregar película de test'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
