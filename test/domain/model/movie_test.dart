import 'package:flutter_test/flutter_test.dart';
import 'package:uponorflix/domain/enum/movie_category.dart';
import 'package:uponorflix/domain/enum/movie_type.dart';
import 'package:uponorflix/domain/model/movie.dart';

void main() {
  group('Movie', () {
    test('should create a Movie with default values', () {
      final movie = Movie(
        title: 'Test Movie',
        description: 'A test description',
        category: MovieCategory.comedy,
      );

      expect(movie.id, '');
      expect(movie.title, 'Test Movie');
      expect(movie.description, 'A test description');
      expect(movie.category, MovieCategory.comedy);
      expect(movie.trailerUrl, '');
      expect(movie.type, MovieType.movie);
      expect(movie.imageUrl, '');
    });

    test('should generate imageUrl from trailerUrl', () {
      final trailerUrl = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ';
      final movie = Movie(
        title: 'Test Movie',
        description: 'A test description',
        category: MovieCategory.action,
        trailerUrl: trailerUrl,
      );

      expect(
        movie.imageUrl,
        'https://img.youtube.com/vi/dQw4w9WgXcQ/hqdefault.jpg',
      );
    });

    test('fromJson should parse Movie correctly', () {
      final data = {
        'title': 'Json Movie',
        'description': 'Json description',
        'category': 'comedy',
        'trailerUrl': 'https://www.youtube.com/watch?v=abc123',
        'type': 'series',
      };

      final movie = Movie.fromJson(data, 'movieId');

      expect(movie.id, 'movieId');
      expect(movie.title, 'Json Movie');
      expect(movie.description, 'Json description');
      expect(movie.category, MovieCategory.comedy);
      expect(movie.trailerUrl, 'https://www.youtube.com/watch?v=abc123');
      expect(movie.type, MovieType.series);
    });

    test('fromJson should fallback to default values', () {
      final data = <String, dynamic>{};

      final movie = Movie.fromJson(data, 'id123');

      expect(movie.id, 'id123');
      expect(movie.title, '');
      expect(movie.description, '');
      expect(movie.category, MovieCategory.action);
      expect(movie.trailerUrl, '');
      expect(movie.type, MovieType.movie);
    });

    test('toJson should serialize Movie correctly', () {
      final movie = Movie(
        id: 'id1',
        title: 'Serialize Movie',
        description: 'Serialize description',
        category: MovieCategory.horror,
        trailerUrl: 'https://www.youtube.com/watch?v=xyz789',
        type: MovieType.series,
      );

      final json = movie.toJson();

      expect(json['title'], 'Serialize Movie');
      expect(json['description'], 'Serialize description');
      expect(json['trailerUrl'], 'https://www.youtube.com/watch?v=xyz789');
      expect(json['category'], 'horror');
      expect(json['type'], 'series');
    });
  });
}
