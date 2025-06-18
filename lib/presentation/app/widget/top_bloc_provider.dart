import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uponorflix/data/repository/movie_repository_impl.dart';
import 'package:uponorflix/presentation/home/bloc/movie_bloc.dart';
import 'package:uponorflix/presentation/settings/bloc/language_bloc.dart';
import 'package:uponorflix/presentation/settings/bloc/theme_bloc.dart';

class TopBlocProvider extends StatelessWidget {
  const TopBlocProvider({
    super.key,
    required this.child,
    required SharedPreferences prefs,
    required MovieRepositoryImpl firestoreService,
  }) : _prefs = prefs,
       _firestoreService = firestoreService;

  final SharedPreferences _prefs;
  final MovieRepositoryImpl _firestoreService;
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
              MovieBloc(firestoreService: _firestoreService)..add(LoadMovies()),
        ),
      ],
      child: child,
    );
  }
}
