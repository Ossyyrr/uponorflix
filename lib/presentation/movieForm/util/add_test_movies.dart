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
      category: MovieCategory.adventure.name,
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
      category: MovieCategory.fantasy.name,
      type: MovieType.movie,
    ),
    Movie(
      title: 'Spider-Man: Un nuevo universo',
      description:
          'Miles Morales se convierte en Spider-Man y se une a otros Spider-People de diferentes dimensiones para salvar el multiverso.',
      trailerUrl:
          'https://www.youtube.com/watch?v=ii3n7hYQOl4&ab_channel=SonyPicturesEspaña',
      category: MovieCategory.action.name,
      type: MovieType.movie,
    ),
    Movie(
      title: 'Avatar',
      description:
          'Un ex-marine parapléjico es enviado a la luna Pandora en una misión única, pero se debate entre seguir órdenes y proteger el mundo que siente como suyo.',
      trailerUrl:
          'https://www.youtube.com/watch?v=5PSNL1qE6VY&ab_channel=20thCenturyStudiosEspaña',
      category: MovieCategory.fantasy.name,
      type: MovieType.movie,
    ),
    Movie(
      title: 'Breaking Bad',
      description:
          'Un profesor de química se convierte en fabricante de metanfetamina tras ser diagnosticado con cáncer.',
      trailerUrl:
          'https://www.youtube.com/watch?v=HhesaQXLuRY&ab_channel=BreakingBad',
      category: MovieCategory.drama.name,
      type: MovieType.series,
    ),
    Movie(
      title: 'The Mandalorian',
      description:
          'Un cazarrecompensas viaja por la galaxia protegiendo a un misterioso niño de la misma especie que Yoda.',
      trailerUrl:
          'https://www.youtube.com/watch?v=aOC8E8z_ifw&ab_channel=StarWarsEspa%C3%B1a',
      category: MovieCategory.adventure.name,
      type: MovieType.series,
    ),
    Movie(
      title: 'The Office',
      description:
          'Una comedia sobre la vida diaria de los empleados de una oficina de ventas de papel en Scranton.',
      trailerUrl:
          'https://www.youtube.com/watch?v=Vmb1tqYqyII&ab_channel=TheOffice',
      category: MovieCategory.comedy.name,
      type: MovieType.series,
    ),
  ];
  Navigator.of(context).pop();
  for (final movie in movies) {
    await firestoreService.addMovie(movie);
  }
}
