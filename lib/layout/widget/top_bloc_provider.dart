import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uponorflix/data/service/firestore_service.dart';
import 'package:uponorflix/layout/home/bloc/home_bloc.dart';
import 'package:uponorflix/layout/settings/bloc/language_bloc.dart';
import 'package:uponorflix/layout/settings/bloc/theme_bloc.dart';

class TopBlocProvider extends StatelessWidget {
  const TopBlocProvider({
    super.key,
    required this.child,
    required SharedPreferences prefs,
    required FirestoreService firestoreService,
  }) : _prefs = prefs,
       _firestoreService = firestoreService;

  final SharedPreferences _prefs;
  final FirestoreService _firestoreService;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              LanguageBloc(prefs: _prefs)..add(LoadLanguageEvent()),
        ),
        BlocProvider(
          create: (context) => ThemeBloc(prefs: _prefs)..add(LoadThemeEvent()),
        ),
        BlocProvider(
          create: (_) =>
              HomeBloc(firestoreService: _firestoreService)..add(LoadMovies()),
        ),
      ],
      child: child,
    );
  }
}
