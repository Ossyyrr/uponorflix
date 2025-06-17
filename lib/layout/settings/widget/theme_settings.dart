import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uponorflix/l10n/app_localizations.dart';
import 'package:uponorflix/layout/settings/bloc/theme_bloc.dart';

class ThemeSettings extends StatelessWidget {
  const ThemeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppLocalizations.of(context)!.darkMode,
          style: const TextStyle(fontSize: 18),
        ),
        BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            return Switch(
              value: themeState.themeMode == ThemeMode.dark,
              onChanged: (value) {
                context.read<ThemeBloc>().add(ToggleThemeEvent());
              },
            );
          },
        ),
      ],
    );
  }
}
