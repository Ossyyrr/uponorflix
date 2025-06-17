import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uponorflix/l10n/app_localizations.dart';
import 'package:uponorflix/layout/settings/bloc/language_bloc.dart';

class LanguageSettings extends StatelessWidget {
  const LanguageSettings({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, Locale> getLocalizedLanguageMap(BuildContext context) {
      return {
        AppLocalizations.of(context)!.spanish: const Locale('es'),
        AppLocalizations.of(context)!.english: const Locale('en'),
      };
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppLocalizations.of(context)!.language,
          style: const TextStyle(fontSize: 18),
        ),
        BlocBuilder<LanguageBloc, Locale>(
          builder: (context, locale) {
            final languageMap = getLocalizedLanguageMap(context);

            String selectedLanguage = languageMap.entries
                .firstWhere(
                  (entry) => entry.value.languageCode == locale.languageCode,
                  orElse: () => MapEntry(
                    AppLocalizations.of(context)!.spanish,
                    const Locale('es'),
                  ),
                )
                .key;

            return DropdownButton<String>(
              value: selectedLanguage,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  Locale newLocale = languageMap[newValue]!;
                  context.read<LanguageBloc>().add(
                    ChangeLanguageEvent(newLocale),
                  );
                }
              },
              items: languageMap.keys.map<DropdownMenuItem<String>>((
                String value,
              ) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
