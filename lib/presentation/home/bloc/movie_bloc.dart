import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uponorflix/data/repository/movie_repository_impl.dart';
import 'package:uponorflix/domain/enum/movie_category.dart';
import 'package:uponorflix/domain/enum/movie_type.dart';
import 'package:uponorflix/domain/model/movie.dart';
import 'package:uponorflix/presentation/utils/enum/screen_status.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepositoryImpl _firestoreService;
  StreamSubscription<List<Movie>>? _moviesSubscription;
  MovieBloc({required MovieRepositoryImpl firestoreService})
    : _firestoreService = firestoreService,
      super(const MovieState(selectedType: null, selectedCategory: null)) {
    on<LoadMovies>(_onLoadMovies);
    on<AddMovie>(_onAddMovie);
    on<UpdateMovie>(_onUpdateMovie);
    on<DeleteMovie>(_onDeleteMovie);
    on<MoviesUpdatedListener>(_onMoviesUpdatedListener);
    on<ChangeCategoryFilter>(
      (event, emit) => emit(
        state.copyWith(
          selectedCategory: event.category,
          selectedType: state.selectedType,
        ),
      ),
    );
    on<ChangeTypeFilter>(
      (event, emit) => emit(
        state.copyWith(
          selectedType: event.type,
          selectedCategory: state.selectedCategory,
        ),
      ),
    );
  }
  void _onMoviesUpdatedListener(
    MoviesUpdatedListener event,
    Emitter<MovieState> emit,
  ) {
    emit(
      state.copyWith(
        status: ScreenStatus.success,
        movies: event.movies,
        errorMessage: null,
      ),
    );
  }

  void _onLoadMovies(LoadMovies event, Emitter<MovieState> emit) {
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

  Future<void> _onAddMovie(AddMovie event, Emitter<MovieState> emit) async {
    final result = await _firestoreService.addMovie(event.movie);
    result.when(
      success: (_) => emit(state.copyWith(status: ScreenStatus.success)),
      error: (error) =>
          emit(state.copyWith(status: ScreenStatus.error, errorMessage: error)),
    );
  }

  Future<void> _onUpdateMovie(
    UpdateMovie event,
    Emitter<MovieState> emit,
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
    Emitter<MovieState> emit,
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
