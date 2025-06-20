import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:uponorflix/data/repository/movie_repository_impl.dart';
import 'package:uponorflix/domain/enum/movie_category.dart';
import 'package:uponorflix/domain/enum/movie_type.dart';
import 'package:uponorflix/domain/model/movie.dart';

import 'movie_repository_impl_test.mocks.dart';

@GenerateMocks([
  FirebaseFirestore,
  CollectionReference<Map<String, dynamic>>,
  DocumentReference<Map<String, dynamic>>,
  QuerySnapshot<Map<String, dynamic>>,
  QueryDocumentSnapshot<Map<String, dynamic>>,
])
void main() {
  group('MovieRepositoryImpl', () {
    late MockFirebaseFirestore mockFirestore;
    late MockCollectionReference<Map<String, dynamic>> mockCollection;
    late MockDocumentReference<Map<String, dynamic>> mockDoc;
    late MovieRepositoryImpl repo;
    late Movie movie;

    setUp(() {
      mockFirestore = MockFirebaseFirestore();
      mockCollection = MockCollectionReference<Map<String, dynamic>>();
      mockDoc = MockDocumentReference<Map<String, dynamic>>();
      repo = MovieRepositoryImpl(db: mockFirestore);
      movie = Movie(
        id: '1',
        title: 'Test',
        description: 'desc',
        category: MovieCategory.action,
        trailerUrl: 'https://youtu.be/test',
        type: MovieType.movie,
      );
    });

    test('addMovie returns success on add', () async {
      when(mockFirestore.collection('movies')).thenReturn(mockCollection);
      when(mockCollection.add(any)).thenAnswer((_) async => mockDoc);

      final result = await repo.addMovie(movie);

      expect(result.isSuccess, true);
      verify(mockCollection.add(movie.toJson())).called(1);
    });

    test('addMovie returns error on exception', () async {
      when(mockFirestore.collection('movies')).thenReturn(mockCollection);
      when(mockCollection.add(any)).thenThrow(Exception('fail'));

      final result = await repo.addMovie(movie);

      expect(result.isError, true);
    });

    test('updateMovie returns success on update', () async {
      when(mockFirestore.collection('movies')).thenReturn(mockCollection);
      when(mockCollection.doc(movie.id)).thenReturn(mockDoc);
      when(mockDoc.update(any)).thenAnswer((_) async {});

      final result = await repo.updateMovie(movie);

      expect(result.isSuccess, true);
      verify(mockDoc.update(movie.toJson())).called(1);
    });

    test('updateMovie returns error on exception', () async {
      when(mockFirestore.collection('movies')).thenReturn(mockCollection);
      when(mockCollection.doc(movie.id)).thenReturn(mockDoc);
      when(mockDoc.update(any)).thenThrow(Exception('fail'));

      final result = await repo.updateMovie(movie);

      expect(result.isError, true);
    });

    test('deleteMovie returns success on delete', () async {
      when(mockFirestore.collection('movies')).thenReturn(mockCollection);
      when(mockCollection.doc('1')).thenReturn(mockDoc);
      when(mockDoc.delete()).thenAnswer((_) async {});

      final result = await repo.deleteMovie('1');

      expect(result.isSuccess, true);
      verify(mockDoc.delete()).called(1);
    });

    test('deleteMovie returns error on exception', () async {
      when(mockFirestore.collection('movies')).thenReturn(mockCollection);
      when(mockCollection.doc('1')).thenReturn(mockDoc);
      when(mockDoc.delete()).thenThrow(Exception('fail'));

      final result = await repo.deleteMovie('1');

      expect(result.isError, true);
    });
    test('getMovies emits empty list when no documents', () async {
      final mockSnapshot = MockQuerySnapshot<Map<String, dynamic>>();
      when(mockFirestore.collection('movies')).thenReturn(mockCollection);
      when(
        mockCollection.snapshots(),
      ).thenAnswer((_) => Stream.value(mockSnapshot));
      when(mockSnapshot.docs).thenReturn([]);

      final stream = repo.getMovies();
      final movies = await stream.first;

      expect(movies, isA<List<Movie>>());
      expect(movies, isEmpty);
    });

    test('getMovies handles multiple documents', () async {
      final mockSnapshot = MockQuerySnapshot<Map<String, dynamic>>();
      final mockDocSnap1 = MockQueryDocumentSnapshot<Map<String, dynamic>>();
      final mockDocSnap2 = MockQueryDocumentSnapshot<Map<String, dynamic>>();
      when(mockFirestore.collection('movies')).thenReturn(mockCollection);
      when(
        mockCollection.snapshots(),
      ).thenAnswer((_) => Stream.value(mockSnapshot));
      when(mockSnapshot.docs).thenReturn([mockDocSnap1, mockDocSnap2]);
      when(mockDocSnap1.data()).thenReturn({
        'title': 'Movie 1',
        'description': 'desc1',
        'category': 'action',
        'trailerUrl': 'https://youtu.be/1',
        'imageUrl': 'https://img.youtube.com/vi/1/hqdefault.jpg',
        'type': 'movie',
      });
      when(mockDocSnap1.id).thenReturn('1');
      when(mockDocSnap2.data()).thenReturn({
        'title': 'Movie 2',
        'description': 'desc2',
        'category': 'comedy',
        'trailerUrl': 'https://youtu.be/2',
        'imageUrl': 'https://img.youtube.com/vi/2/hqdefault.jpg',
        'type': 'movie',
      });
      when(mockDocSnap2.id).thenReturn('2');

      final stream = repo.getMovies();
      final movies = await stream.first;

      expect(movies, isA<List<Movie>>());
      expect(movies.length, 2);
      expect(movies[0].title, 'Movie 1');
      expect(movies[1].category, MovieCategory.comedy);
    });

    test('getMovies throws if snapshot stream throws', () async {
      when(mockFirestore.collection('movies')).thenReturn(mockCollection);
      when(
        mockCollection.snapshots(),
      ).thenAnswer((_) => Stream.error(Exception('fail')));

      final stream = repo.getMovies();

      expect(stream.first, throwsA(isA<Exception>()));
    });
  });
}
