import 'package:flutter/material.dart';
import 'package:uponorflix/domain/enum/movie_category.dart';
import 'package:uponorflix/domain/enum/movie_type.dart';
import 'package:uponorflix/domain/interface/movie_repository.dart';
import 'package:uponorflix/domain/model/movie.dart';

void addTestMovies(
  BuildContext context,
  MovieRepository firestoreService,
) async {
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
    await firestoreService.addMovie(movie);
  }
  Navigator.of(context).pop();
}
