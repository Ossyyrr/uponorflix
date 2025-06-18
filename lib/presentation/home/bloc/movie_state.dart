part of 'movie_bloc.dart';

class MovieState {
  final ScreenStatus status;
  final List<Movie> movies;
  final String? errorMessage;
  final MovieCategory? selectedCategory;
  final MovieType? selectedType;

  const MovieState({
    this.status = ScreenStatus.initial,
    this.movies = const [],
    this.errorMessage,
    this.selectedCategory,
    this.selectedType,
  });

  List<Movie> get filteredMovies {
    return movies.where((movie) {
      final matchesCategory =
          selectedCategory == null || movie.category == selectedCategory;
      final matchesType = selectedType == null || movie.type == selectedType;
      return matchesCategory && matchesType;
    }).toList();
  }

  Map<MovieCategory, List<Movie>> get moviesByCategory {
    final map = <MovieCategory, List<Movie>>{};
    for (final movie in movies) {
      map.putIfAbsent(movie.category, () => []).add(movie);
    }
    return map;
  }

  Map<MovieCategory, List<Movie>> get filteredMoviesByCategory {
    final map = <MovieCategory, List<Movie>>{};
    for (final movie in filteredMovies) {
      map.putIfAbsent(movie.category, () => []).add(movie);
    }
    return map;
  }

  MovieState copyWith({
    ScreenStatus? status,
    List<Movie>? movies,
    String? errorMessage,
    MovieCategory? selectedCategory,
    MovieType? selectedType,
  }) {
    return MovieState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      errorMessage: errorMessage,
      selectedCategory: selectedCategory, // need null for clean filters.
      selectedType: selectedType,
    );
  }
}
