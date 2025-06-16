import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uponorflix/core/model/movie.dart';

abstract class DataBaseService {
  Future<void> addMovie(Movie movie);
  Future<void> updateMovie(Movie movie);
  Future<void> deleteMovie(String id);
  Stream<List<Movie>> getMovies();
}

class FirestoreService implements DataBaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<void> addMovie(Movie movie) async {
    await _db.collection('movies').add(movie.toJson());
  }

  @override
  Future<void> updateMovie(Movie movie) async {
    await _db.collection('movies').doc(movie.id).update(movie.toJson());
  }

  @override
  Future<void> deleteMovie(String id) async {
    await _db.collection('movies').doc(id).delete();
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
