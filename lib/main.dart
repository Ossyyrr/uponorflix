import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uponorflix/app.dart';
import 'package:uponorflix/data/service/firestore_service.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final prefs = await SharedPreferences.getInstance();
  final FirestoreService firestoreService = FirestoreService();
  runApp(App(prefs: prefs, firestoreService: firestoreService));
}
