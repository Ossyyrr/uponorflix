part of 'movie_bloc.dart';

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

class ChangeCategoryFilter extends MovieEvent {
  final MovieCategory? category;
  ChangeCategoryFilter(this.category);
}

class ChangeTypeFilter extends MovieEvent {
  final MovieType? type;
  ChangeTypeFilter(this.type);
}

class ChangeSearchQuery extends MovieEvent {
  final String query;
  ChangeSearchQuery(this.query);
}
