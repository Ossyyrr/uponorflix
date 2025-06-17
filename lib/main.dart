import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uponorflix/data/repository/movie_repository_impl.dart';
import 'package:uponorflix/presentation/app/app.dart';

import 'presentation/app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final prefs = await SharedPreferences.getInstance();
  // TODO Maybe use getIt
  final MovieRepositoryImpl firestoreService = MovieRepositoryImpl();
  runApp(App(prefs: prefs, firestoreService: firestoreService));
}
