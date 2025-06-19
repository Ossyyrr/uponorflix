import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uponorflix/domain/enum/movie_category.dart';
import 'package:uponorflix/domain/enum/movie_type.dart';
import 'package:uponorflix/domain/model/movie.dart';
import 'package:uponorflix/presentation/movieForm/util/add_test_movies.dart';
import 'package:uponorflix/presentation/movieForm/widget/form_app_bar.dart';
import 'package:uponorflix/presentation/movieForm/widget/form_background.dart';
import 'package:uponorflix/presentation/movieForm/widget/movie_type_choice_chips.dart';
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

  MovieCategory? _selectedCategory;
  MovieType _selectedType = MovieType.movie;

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
    _selectedCategory = widget.movie?.category;
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
        category: _selectedCategory!,
        type: _selectedType,
      );
      Navigator.of(context).pop(movie);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Stack(
        children: [
          FormBackground(),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 150,
                left: 24,
                right: 24,
                bottom: 24,
              ),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 500),
                decoration: BoxDecoration(
                  color: colorScheme.surface.withAlpha(242),
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: Colors.white, width: 6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(77),
                      blurRadius: 32,
                      offset: const Offset(0, 16),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            labelText: 'Título',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            filled: true,
                            fillColor: colorScheme.surfaceBright,
                            prefixIcon: Icon(
                              Icons.movie,
                              color: colorScheme.primary,
                            ),
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Ingrese un título'
                              : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            labelText: 'Descripción',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            filled: true,
                            fillColor: colorScheme.surfaceBright,
                            prefixIcon: Icon(
                              Icons.description,
                              color: colorScheme.primary,
                            ),
                          ),
                          maxLines: 3,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Ingrese una descripción'
                              : null,
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<MovieCategory>(
                          value: _selectedCategory,
                          decoration: InputDecoration(
                            labelText: 'Categoría',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            filled: true,
                            fillColor: colorScheme.surfaceBright,
                            prefixIcon: Icon(
                              Icons.category,
                              color: colorScheme.primary,
                            ),
                          ),
                          items: MovieCategory.values
                              .map(
                                (cat) => DropdownMenuItem(
                                  value: cat,
                                  child: Text(getCategoryLabel(context, cat)),
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
                        const SizedBox(height: 16),
                        MovieTypeChoiceChips(
                          selectedType: _selectedType,
                          onTypeChanged: (type) {
                            setState(() {
                              _selectedType = type;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _trailerUrlController,
                          decoration: InputDecoration(
                            labelText: 'Enlace de YouTube (tráiler)',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            filled: true,
                            fillColor: colorScheme.surfaceBright,
                            prefixIcon: Icon(
                              Icons.link,
                              color: colorScheme.primary,
                            ),
                          ),
                          validator: (value) {
                            // TODO llevar a otro archivo
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
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton.icon(
                            onPressed: _save,
                            icon: const Icon(Icons.save, size: 28),
                            label: const Text(
                              'Guardar',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.primary,
                              foregroundColor: colorScheme.onPrimary,
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              shadowColor: colorScheme.primary.withAlpha(77),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (kDebugMode)
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton.icon(
                              onPressed: () => addTestMovie(context),
                              icon: const Icon(Icons.bug_report),
                              label: const Text('Agregar películas de test'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          FormAppBar(widget: widget), // TODO
        ],
      ),
    );
  }
}
