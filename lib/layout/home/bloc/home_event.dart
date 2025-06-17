// filepath: /Users/ossyyrr/Developer/uponorflix/lib/layout/home/bloc/home_event.dart
part of 'home_bloc.dart';

class HomeEvent {}

class LoadMovies extends HomeEvent {}

class AddMovie extends HomeEvent {
  final Movie movie;
  AddMovie(this.movie);
}

class UpdateMovie extends HomeEvent {
  final Movie movie;
  UpdateMovie(this.movie);
}

class DeleteMovie extends HomeEvent {
  final String id;
  DeleteMovie(this.id);
}

class MoviesUpdatedListener extends HomeEvent {
  final List<Movie> movies;
  MoviesUpdatedListener(this.movies);
}
