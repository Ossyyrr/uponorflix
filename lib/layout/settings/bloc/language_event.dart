part of 'language_bloc.dart';

abstract class LanguageEvent {}

class ChangeLanguageEvent extends LanguageEvent {
  final Locale locale;
  ChangeLanguageEvent(this.locale);
}

class LoadLanguageEvent extends LanguageEvent {}
