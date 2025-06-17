// filepath: /Users/ossyyrr/Developer/uponorflix/lib/layout/home/bloc/home_event.dart
part of 'home_bloc.dart';

class MovieEvent {}

class LoadMovies extends MovieEvent {}

class AddMovie extends MovieEvent {
  final Movie movie;
  AddMovie(this.movie);
}

class UpdateMovie extends MovieEvent {
  final Movie movie;
  UpdateMovie(this.movie);
}

class DeleteMovie extends MovieEvent {
  final String id;
  DeleteMovie(this.id);
}

class MoviesUpdatedListener extends MovieEvent {
  final List<Movie> movies;
  MoviesUpdatedListener(this.movies);
}
