import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uponorflix/domain/enum/movie_category.dart';
import 'package:uponorflix/domain/enum/movie_type.dart';
import 'package:uponorflix/domain/model/movie.dart';
import 'package:uponorflix/presentation/home/bloc/movie_bloc.dart';

void addTestMovie(BuildContext context) async {
  final movies = [
    Movie(
      title: 'Cómo entrenar a tu dragón',
      description:
          'Un joven vikingo se hace amigo de un dragón herido y descubre que los dragones no son lo que parecen.',
      trailerUrl:
          'https://www.youtube.com/watch?v=Ns6ZEpQ1xS0&ab_channel=UniversalSpain',
      category: MovieCategory.adventure,
      type: MovieType.movie,
    ),
    Movie(
      title: 'Interestelar',
      description:
          'Un grupo de exploradores viaja a través de un agujero de gusano en el espacio en un intento de asegurar la supervivencia de la humanidad.',
      trailerUrl:
          'https://www.youtube.com/watch?v=2LqzF5WauAw&ab_channel=InterstellarMovie',
      category: MovieCategory.sciFi,
      type: MovieType.movie,
    ),
    Movie(
      title: 'Vaiana',
      description:
          'Una joven polinesia se embarca en una aventura oceánica para salvar a su pueblo y descubrir su verdadero destino.',
      trailerUrl:
          'https://www.youtube.com/watch?v=79DijItQXMM&ab_channel=DisneyEspaña',
      category: MovieCategory.fantasy,
      type: MovieType.movie,
    ),
    Movie(
      title: 'Spider-Man: Un nuevo universo',
      description:
          'Miles Morales se convierte en Spider-Man y se une a otros Spider-People de diferentes dimensiones para salvar el multiverso.',
      trailerUrl:
          'https://www.youtube.com/watch?v=ii3n7hYQOl4&ab_channel=SonyPicturesEspaña',
      category: MovieCategory.action,
      type: MovieType.movie,
    ),
    Movie(
      title: 'Avatar',
      description:
          'Un ex-marine parapléjico es enviado a la luna Pandora en una misión única, pero se debate entre seguir órdenes y proteger el mundo que siente como suyo.',
      trailerUrl:
          'https://www.youtube.com/watch?v=CpXJHWSXJW0&ab_channel=CineFantasia',
      category: MovieCategory.fantasy,
      type: MovieType.movie,
    ),
    Movie(
      title: 'Breaking Bad',
      description:
          'Un profesor de química se convierte en fabricante de metanfetamina tras ser diagnosticado con cáncer.',
      trailerUrl:
          'https://www.youtube.com/watch?v=HhesaQXLuRY&ab_channel=BreakingBad',
      category: MovieCategory.drama,
      type: MovieType.series,
    ),
    Movie(
      title: 'The Mandalorian',
      description:
          'Un cazarrecompensas viaja por la galaxia protegiendo a un misterioso niño de la misma especie que Yoda.',
      trailerUrl:
          'https://www.youtube.com/watch?v=aOC8E8z_ifw&ab_channel=StarWarsEspa%C3%B1a',
      category: MovieCategory.adventure,
      type: MovieType.series,
    ),
    Movie(
      title: 'The Office',
      description:
          'Una comedia sobre la vida diaria de los empleados de una oficina de ventas de papel en Scranton.',
      trailerUrl:
          'https://www.youtube.com/watch?v=tNcDHWpselE&ab_channel=MaxBrasil',
      category: MovieCategory.comedy,
      type: MovieType.series,
    ),
    Movie(
      title: 'Marte (The Martian)',
      description:
          'Un astronauta queda atrapado en Marte y debe sobrevivir mientras espera ser rescatado.',
      trailerUrl:
          'https://www.youtube.com/watch?v=ej3ioOneTy8&ab_channel=20thCenturyStudiosEspaña',
      category: MovieCategory.sciFi,
      type: MovieType.movie,
    ),
    Movie(
      title: 'Chernobyl',
      description:
          'Miniserie que relata los eventos del desastre nuclear de Chernóbil y sus consecuencias.',
      trailerUrl:
          'https://www.youtube.com/watch?v=s9APLXM9Ei8&ab_channel=HBOEspana',
      category: MovieCategory.drama,
      type: MovieType.series,
    ),
    Movie(
      title: 'Arcane',
      description:
          'En la ciudad de Piltover, dos hermanas se ven envueltas en una guerra entre tecnologías mágicas y conflictos sociales.',
      trailerUrl:
          'https://www.youtube.com/watch?v=fXmAurh012s&ab_channel=Netflix',
      category: MovieCategory.anime,
      type: MovieType.series,
    ),
  ];

  final random = Random();
  final randomMovie = movies[random.nextInt(movies.length)];
  context.read<MovieBloc>().add(AddMovie(randomMovie));
  Navigator.of(context).pop();
}
