import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uponorflix/domain/interface/movie_repository.dart';
import 'package:uponorflix/presentation/home/bloc/movie_bloc.dart';
import 'package:uponorflix/presentation/settings/bloc/language_bloc.dart';
import 'package:uponorflix/presentation/settings/bloc/theme_bloc.dart';

class TopBlocProvider extends StatelessWidget {
  const TopBlocProvider({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final prefs = GetIt.instance<SharedPreferences>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              LanguageBloc(prefs: prefs)..add(LoadLanguageEvent()),
        ),
        BlocProvider(
          create: (context) => ThemeBloc(prefs: prefs)..add(LoadThemeEvent()),
        ),
        BlocProvider(
          create: (_) =>
              MovieBloc(firestoreService: GetIt.instance<MovieRepository>())
                ..add(LoadMovies()),
        ),
      ],
      child: child,
    );
  }
}
