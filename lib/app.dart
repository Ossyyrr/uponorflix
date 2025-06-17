import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uponorflix/l10n/app_localizations.dart';
import 'package:uponorflix/layout/home/home_screen.dart';
import 'package:uponorflix/layout/settings/bloc/language_bloc.dart';
import 'package:uponorflix/layout/settings/bloc/theme_bloc.dart';
import 'package:uponorflix/layout/utils/app_theme.dart';
import 'package:uponorflix/layout/widget/top_bloc_provider.dart';

class App extends StatelessWidget {
  final SharedPreferences prefs;
  const App({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return TopBlocProvider(
      prefs: prefs,
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
                home: const HomeScreen(title: 'UponorFlix'),
              );
            },
          );
        },
      ),
    );
  }
}
