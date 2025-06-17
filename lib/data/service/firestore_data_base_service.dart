import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uponorflix/domain/interface/data_base_service.dart';
import 'package:uponorflix/domain/model/movie.dart';
import 'package:uponorflix/domain/result.dart';

class FirestoreDataBaseService implements DataBaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<Result<void>> addMovie(Movie movie) async {
    try {
      await _db.collection('movies').add(movie.toJson());
      return Result.success(null);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<void>> updateMovie(Movie movie) async {
    try {
      await _db.collection('movies').doc(movie.id).update(movie.toJson());
      return Result.success(null);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<void>> deleteMovie(String id) async {
    try {
      await _db.collection('movies').doc(id).delete();
      return Result.success(null);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Stream<List<Movie>> getMovies() {
    return _db
        .collection('movies')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Movie.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }
}
