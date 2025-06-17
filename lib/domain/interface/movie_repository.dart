import 'package:uponorflix/domain/model/movie.dart';
import 'package:uponorflix/domain/result.dart';

abstract class MovieRepository {
  Future<Result<void>> addMovie(Movie movie);
  Future<Result<void>> updateMovie(Movie movie);
  Future<Result<void>> deleteMovie(String id);
  Stream<List<Movie>> getMovies();
}
