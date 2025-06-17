import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uponorflix/presentation/utils/shared_prefereces_utils.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SharedPreferences _prefs;

  ThemeBloc({required SharedPreferences prefs})
    : _prefs = prefs,
      super(ThemeState(themeMode: _getInitialThemeMode(prefs))) {
    on<LoadThemeEvent>(_onLoadTheme);
    on<ToggleThemeEvent>(_onToggleTheme);
  }

  static ThemeMode _getInitialThemeMode(SharedPreferences prefs) {
    final saved = prefs.getString(SharedPreferencesUtils.theme);
    if (saved != null) {
      return saved == 'dark' ? ThemeMode.dark : ThemeMode.light;
    }

    return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
            Brightness.dark
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  Future<void> _onLoadTheme(
    LoadThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    emit(ThemeState(themeMode: _getInitialThemeMode(_prefs)));
  }

  Future<void> _onToggleTheme(
    ToggleThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    final isCurrentlyDark = state.themeMode == ThemeMode.dark;
    final newMode = isCurrentlyDark ? ThemeMode.light : ThemeMode.dark;
    await _prefs.setString(
      SharedPreferencesUtils.theme,
      newMode == ThemeMode.dark ? 'dark' : 'light',
    );
    emit(ThemeState(themeMode: newMode));
  }
}
