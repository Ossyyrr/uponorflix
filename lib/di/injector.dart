import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uponorflix/data/repository/movie_repository_impl.dart';
import 'package:uponorflix/domain/interface/movie_repository.dart';

final GetIt getIt = GetIt.instance;

void setupInjector({required SharedPreferences prefs}) {
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
  getIt.registerLazySingleton<SharedPreferences>(() => prefs);
  getIt.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(db: getIt<FirebaseFirestore>()),
  );
}
