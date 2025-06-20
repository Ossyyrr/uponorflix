import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:uponorflix/domain/enum/movie_category.dart';
import 'package:uponorflix/domain/enum/movie_type.dart';
import 'package:uponorflix/domain/interface/movie_repository.dart';
import 'package:uponorflix/domain/model/movie.dart';
import 'package:uponorflix/domain/result.dart';
import 'package:uponorflix/presentation/home/bloc/movie_bloc.dart';
import 'package:uponorflix/presentation/utils/enum/screen_status.dart';

import 'movie_bloc_test.mocks.dart';

@GenerateMocks([MovieRepository])
void main() {
  group('MovieBloc', () {
    late MockMovieRepository mockRepo;
    late MovieBloc bloc;
    final movie = Movie(
      id: '1',
      title: 'Test',
      description: 'desc',
      category: MovieCategory.action,
      trailerUrl: 'https://youtu.be/test',
      type: MovieType.movie,
    );

    setUp(() {
      mockRepo = MockMovieRepository();
      bloc = MovieBloc(firestoreService: mockRepo);
    });

    tearDown(() async {
      await bloc.close();
    });

    test('initial state', () {
      expect(bloc.state.status, ScreenStatus.initial);
      expect(bloc.state.movies, []);
      expect(bloc.state.selectedCategory, null);
      expect(bloc.state.selectedType, null);
      expect(bloc.state.searchQuery, '');
    });

    test('LoadMovies emits loading then success with movies', () async {
      final movies = [movie];
      when(mockRepo.getMovies()).thenAnswer((_) => Stream.value(movies));

      bloc.add(LoadMovies());

      await expectLater(
        bloc.stream,
        emitsInOrder([
          predicate<MovieState>((s) => s.status == ScreenStatus.loading),
          predicate<MovieState>(
            (s) => s.status == ScreenStatus.success && s.movies == movies,
          ),
        ]),
      );
    });
    test('LoadMovies emits error if repository stream throws', () async {
      when(
        mockRepo.getMovies(),
      ).thenAnswer((_) => Stream.error(Exception('fail')));

      bloc.add(LoadMovies());

      await expectLater(
        bloc.stream,
        emitsInOrder([
          predicate<MovieState>((s) => s.status == ScreenStatus.loading),
          predicate<MovieState>(
            (s) => s.status == ScreenStatus.error && s.errorMessage != null,
          ),
        ]),
      );
    });

    test('AddMovie emits success on repository success', () async {
      when(
        mockRepo.addMovie(any),
      ).thenAnswer((_) async => Result.success(null));

      bloc.add(AddMovie(movie));

      await expectLater(
        bloc.stream,
        emits(predicate<MovieState>((s) => s.status == ScreenStatus.success)),
      );
    });

    test('AddMovie emits error on repository error', () async {
      when(
        mockRepo.addMovie(any),
      ).thenAnswer((_) async => Result.error('fail'));

      bloc.add(AddMovie(movie));

      await expectLater(
        bloc.stream,
        emits(
          predicate<MovieState>(
            (s) => s.status == ScreenStatus.error && s.errorMessage == 'fail',
          ),
        ),
      );
    });

    test('UpdateMovie emits success on repository success', () async {
      when(
        mockRepo.updateMovie(any),
      ).thenAnswer((_) async => Result.success(null));

      bloc.add(UpdateMovie(movie));

      await expectLater(
        bloc.stream,
        emits(predicate<MovieState>((s) => s.status == ScreenStatus.success)),
      );
    });

    test('UpdateMovie emits error on repository error', () async {
      when(
        mockRepo.updateMovie(any),
      ).thenAnswer((_) async => Result.error('fail'));

      bloc.add(UpdateMovie(movie));

      await expectLater(
        bloc.stream,
        emits(
          predicate<MovieState>(
            (s) => s.status == ScreenStatus.error && s.errorMessage == 'fail',
          ),
        ),
      );
    });

    test('DeleteMovie emits success on repository success', () async {
      when(
        mockRepo.deleteMovie(any),
      ).thenAnswer((_) async => Result.success(null));

      bloc.add(DeleteMovie('1'));

      await expectLater(
        bloc.stream,
        emits(predicate<MovieState>((s) => s.status == ScreenStatus.success)),
      );
    });

    test('DeleteMovie emits error on repository error', () async {
      when(
        mockRepo.deleteMovie(any),
      ).thenAnswer((_) async => Result.error('fail'));

      bloc.add(DeleteMovie('1'));

      await expectLater(
        bloc.stream,
        emits(
          predicate<MovieState>(
            (s) => s.status == ScreenStatus.error && s.errorMessage == 'fail',
          ),
        ),
      );
    });

    test('ChangeCategoryFilter updates selectedCategory', () async {
      bloc.add(ChangeCategoryFilter(MovieCategory.comedy));

      await expectLater(
        bloc.stream,
        emits(
          predicate<MovieState>(
            (s) => s.selectedCategory == MovieCategory.comedy,
          ),
        ),
      );
    });

    test('ChangeTypeFilter updates selectedType', () async {
      bloc.add(ChangeTypeFilter(MovieType.series));

      await expectLater(
        bloc.stream,
        emits(predicate<MovieState>((s) => s.selectedType == MovieType.series)),
      );
    });

    test('ChangeSearchQuery updates searchQuery', () async {
      bloc.add(ChangeSearchQuery('batman'));

      await expectLater(
        bloc.stream,
        emits(predicate<MovieState>((s) => s.searchQuery == 'batman')),
      );
    });
  });
}
