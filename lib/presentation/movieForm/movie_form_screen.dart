import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uponorflix/data/repository/movie_repository_impl.dart';
import 'package:uponorflix/domain/enum/movie_category.dart';
import 'package:uponorflix/domain/enum/movie_type.dart';
import 'package:uponorflix/domain/model/movie.dart';
import 'package:uponorflix/l10n/app_localizations.dart';
import 'package:uponorflix/presentation/utils/movie_category_localization.dart';

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

  MovieCategory? _selectedCategory;
  MovieType _selectedType = MovieType.movie;

  void _addTestMovie() async {
    final movies = [
      Movie(
        title: 'Cómo entrenar a tu dragón',
        description:
            'Un joven vikingo se hace amigo de un dragón herido y descubre que los dragones no son lo que parecen.',
        trailerUrl:
            'https://www.youtube.com/watch?v=Ns6ZEpQ1xS0&ab_channel=UniversalSpain',
        category: MovieCategory.action.name,
        type: MovieType.movie,
      ),
      Movie(
        title: 'Interestelar',
        description:
            'Un grupo de exploradores viaja a través de un agujero de gusano en el espacio en un intento de asegurar la supervivencia de la humanidad.',
        trailerUrl:
            'https://www.youtube.com/watch?v=zSWdZVtXT7E&ab_channel=WarnerBros.Pictures',
        category: MovieCategory.sciFi.name,
        type: MovieType.movie,
      ),
      Movie(
        title: 'Coco',
        description:
            'Un niño mexicano se embarca en una aventura en la Tierra de los Muertos para descubrir la historia de su familia.',
        trailerUrl:
            'https://www.youtube.com/watch?v=Ga6RYejo6Hk&ab_channel=Pixar',
        category: MovieCategory.anime.name,
        type: MovieType.movie,
      ),
    ];

    for (final movie in movies) {
      await _firestoreService.addMovie(movie);
    }
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
    _selectedCategory = movieCategoryFromString(widget.movie?.category);
    _selectedType = widget.movie?.type ?? MovieType.movie;
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
        trailerUrl: _trailerUrlController.text,
        category: _selectedCategory?.name ?? '',
        type: _selectedType,
      );
      Navigator.of(context).pop(movie);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.movie == null ? 'Nueva Película' : 'Editar Película',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Título'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Ingrese un título'
                      : null,
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Descripción'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Ingrese una descripción'
                      : null,
                ),
                DropdownButtonFormField<MovieCategory>(
                  value: _selectedCategory,
                  decoration: const InputDecoration(labelText: 'Categoría'),
                  items: MovieCategory.values
                      .map(
                        (cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(getCategoryLabel(loc, cat)),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Seleccione una categoría' : null,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    children: [
                      Text(
                        'Tipo:',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(width: 16),
                      ChoiceChip(
                        label: const Text('Película'),
                        selected: _selectedType == MovieType.movie,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              _selectedType = MovieType.movie;
                            });
                          }
                        },
                      ),
                      const SizedBox(width: 8),
                      ChoiceChip(
                        label: const Text('Serie'),
                        selected: _selectedType == MovieType.series,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              _selectedType = MovieType.series;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
                TextFormField(
                  controller: _trailerUrlController,
                  decoration: const InputDecoration(
                    labelText: 'Enlace de YouTube (tráiler)',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese un enlace de YouTube';
                    }
                    final youtubeRegex = RegExp(
                      r'^(https?\:\/\/)?(www\.youtube\.com|youtu\.be)\/.+$',
                      caseSensitive: false,
                    );
                    if (!youtubeRegex.hasMatch(value)) {
                      return 'Ingrese una URL válida de YouTube';
                    }
                    return null;
                  },
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
      ),
    );
  }
}
