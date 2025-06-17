import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uponorflix/data/repository/movie_repository_impl.dart';
import 'package:uponorflix/domain/model/movie.dart';
import 'package:uponorflix/presentation/utils/enum/screen_status.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  // Todo change name to MovieBloc
  final MovieRepositoryImpl _firestoreService;
  StreamSubscription<List<Movie>>? _moviesSubscription;

  HomeBloc({required MovieRepositoryImpl firestoreService})
    : _firestoreService = firestoreService,
      super(const HomeState()) {
    on<LoadMovies>(_onLoadMovies);
    on<AddMovie>(_onAddMovie);
    on<UpdateMovie>(_onUpdateMovie);
    on<DeleteMovie>(_onDeleteMovie);
    on<MoviesUpdatedListener>(_onMoviesUpdatedListener);
  }
  void _onMoviesUpdatedListener(
    MoviesUpdatedListener event,
    Emitter<HomeState> emit,
  ) {
    emit(
      state.copyWith(
        status: ScreenStatus.success,
        movies: event.movies,
        errorMessage: null,
      ),
    );
  }

  void _onLoadMovies(LoadMovies event, Emitter<HomeState> emit) {
    emit(state.copyWith(status: ScreenStatus.loading));
    _moviesSubscription?.cancel();
    _moviesSubscription = _firestoreService.getMovies().listen(
      (movies) {
        add(MoviesUpdatedListener(movies));
      },
      onError: (error) {
        emit(
          state.copyWith(
            status: ScreenStatus.error,
            errorMessage: error.toString(),
          ),
        );
      },
    );
  }

  Future<void> _onAddMovie(AddMovie event, Emitter<HomeState> emit) async {
    final result = await _firestoreService.addMovie(event.movie);
    result.when(
      success: (_) => emit(state.copyWith(status: ScreenStatus.success)),
      error: (error) =>
          emit(state.copyWith(status: ScreenStatus.error, errorMessage: error)),
    );
  }

  Future<void> _onUpdateMovie(
    UpdateMovie event,
    Emitter<HomeState> emit,
  ) async {
    final result = await _firestoreService.updateMovie(event.movie);
    result.when(
      success: (_) => emit(state.copyWith(status: ScreenStatus.success)),
      error: (error) =>
          emit(state.copyWith(status: ScreenStatus.error, errorMessage: error)),
    );
  }

  Future<void> _onDeleteMovie(
    DeleteMovie event,
    Emitter<HomeState> emit,
  ) async {
    final result = await _firestoreService.deleteMovie(event.id);
    result.when(
      success: (_) => emit(state.copyWith(status: ScreenStatus.success)),
      error: (error) =>
          emit(state.copyWith(status: ScreenStatus.error, errorMessage: error)),
    );
  }

  @override
  Future<void> close() {
    _moviesSubscription?.cancel();
    return super.close();
  }
}
