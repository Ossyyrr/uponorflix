part of 'home_bloc.dart';

class HomeState {
  final ScreenStatus status;
  final List<Movie> movies;
  final String? errorMessage;

  const HomeState({
    this.status = ScreenStatus.initial,
    this.movies = const [],
    this.errorMessage,
  });

  HomeState copyWith({
    ScreenStatus? status,
    List<Movie>? movies,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      errorMessage: errorMessage,
    );
  }
}
