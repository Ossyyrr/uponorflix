part of 'home_bloc.dart';

class MovieState {
  final ScreenStatus status;
  final List<Movie> movies;
  final String? errorMessage;

  const MovieState({
    this.status = ScreenStatus.initial,
    this.movies = const [],
    this.errorMessage,
  });

  MovieState copyWith({
    ScreenStatus? status,
    List<Movie>? movies,
    String? errorMessage,
  }) {
    return MovieState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      errorMessage: errorMessage,
    );
  }
}
