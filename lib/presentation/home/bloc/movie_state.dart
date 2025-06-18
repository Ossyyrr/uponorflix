part of 'movie_bloc.dart';

class MovieState {
  final ScreenStatus status;
  final List<Movie> movies;
  final String? errorMessage;

  const MovieState({
    this.status = ScreenStatus.initial,
    this.movies = const [],
    this.errorMessage,
  });
  Map<MovieCategory, List<Movie>> get moviesByCategory {
    final map = <MovieCategory, List<Movie>>{};
    for (final movie in movies) {
      map.putIfAbsent(movie.category, () => []).add(movie);
    }
    return map;
  }

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
