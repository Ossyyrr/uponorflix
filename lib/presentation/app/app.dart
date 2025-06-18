import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uponorflix/data/repository/movie_repository_impl.dart';
import 'package:uponorflix/l10n/app_localizations.dart';
import 'package:uponorflix/presentation/app/widget/top_bloc_provider.dart';
import 'package:uponorflix/presentation/home/home_screen.dart';
import 'package:uponorflix/presentation/settings/bloc/language_bloc.dart';
import 'package:uponorflix/presentation/settings/bloc/theme_bloc.dart';
import 'package:uponorflix/presentation/utils/app_theme.dart';

class App extends StatelessWidget {
  final SharedPreferences prefs;
  final MovieRepositoryImpl firestoreService;
  const App({super.key, required this.prefs, required this.firestoreService});

  @override
  Widget build(BuildContext context) {
    return TopBlocProvider(
      prefs: prefs,
      firestoreService: firestoreService,
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<LanguageBloc, Locale>(
            builder: (context, locale) {
              return MaterialApp(
                title: 'UponorFlix',
                themeMode: themeState.themeMode,
                theme: AppTheme.lightTheme(),
                darkTheme: AppTheme.darkTheme(),
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                locale: locale,
                home: const HomeScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
