import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uponorflix/layout/settings/bloc/language_bloc.dart';
import 'package:uponorflix/layout/settings/bloc/theme_bloc.dart';

class TopBlocProvider extends StatelessWidget {
  const TopBlocProvider({super.key, required this.child, required this.prefs});
  final SharedPreferences prefs;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              LanguageBloc(prefs: prefs)..add(LoadLanguageEvent()),
        ),
        BlocProvider(
          create: (context) => ThemeBloc(prefs: prefs)..add(LoadThemeEvent()),
        ),
      ],
      child: child,
    );
  }
}
