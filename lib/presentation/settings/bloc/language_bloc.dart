import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uponorflix/l10n/app_localizations.dart';
import 'package:uponorflix/presentation/utils/shared_prefereces_utils.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, Locale> {
  final SharedPreferences _prefs;

  LanguageBloc({required SharedPreferences prefs})
    : _prefs = prefs,
      super(_getInitialLocale(prefs)) {
    on<ChangeLanguageEvent>((event, emit) async {
      emit(event.locale);
      await _prefs.setString(
        SharedPreferencesUtils.language,
        event.locale.languageCode,
      );
    });

    on<LoadLanguageEvent>((event, emit) {
      final savedLocale = _prefs.getString(SharedPreferencesUtils.language);
      if (savedLocale != null) {
        emit(Locale(savedLocale));
      } else {
        final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;
        emit(_getResolvedLocale(systemLocale));
      }
    });
  }

  static Locale _getInitialLocale(SharedPreferences prefs) {
    final savedCode = prefs.getString(SharedPreferencesUtils.language);
    if (savedCode != null) {
      return Locale(savedCode);
    }

    final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;
    return _getResolvedLocale(systemLocale);
  }

  static Locale _getResolvedLocale(Locale systemLocale) {
    for (var supported in AppLocalizations.supportedLocales) {
      if (supported.languageCode == systemLocale.languageCode) {
        return supported;
      }
    }
    return const Locale('en');
  }
}
