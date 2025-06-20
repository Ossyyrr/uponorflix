import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uponorflix/l10n/app_localizations.dart';
import 'package:uponorflix/presentation/app/widget/top_bloc_provider.dart';
import 'package:uponorflix/presentation/home/home_screen.dart';
import 'package:uponorflix/presentation/settings/bloc/language_bloc.dart';
import 'package:uponorflix/presentation/settings/bloc/theme_bloc.dart';
import 'package:uponorflix/presentation/utils/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return TopBlocProvider(
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<LanguageBloc, Locale>(
            builder: (context, locale) {
              return Builder(
                builder: (context) {
                  final mediaQuery = MediaQuery.of(context);
                  return MediaQuery(
                    data: mediaQuery.copyWith(
                      textScaler: mediaQuery.textScaler.clamp(
                        minScaleFactor: 1.0,
                        maxScaleFactor: 1.5,
                      ),
                    ),
                    child: MaterialApp(
                      title: 'UponorFlix',
                      themeMode: themeState.themeMode,
                      theme: AppTheme.lightTheme(),
                      darkTheme: AppTheme.darkTheme(),
                      localizationsDelegates:
                          AppLocalizations.localizationsDelegates,
                      supportedLocales: AppLocalizations.supportedLocales,
                      locale: locale,
                      home: const HomeScreen(),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
