import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uponorflix/l10n/app_localizations.dart';
import 'package:uponorflix/presentation/settings/bloc/theme_bloc.dart';

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
            final isDark = themeState.themeMode == ThemeMode.dark;
            return MergeSemantics(
              //switch has their own semantics
              child: Row(
                children: [
                  Semantics(
                    label: isDark
                        ? AppLocalizations.of(context)!.disableDarkMode
                        : AppLocalizations.of(context)!.enableDarkMode,
                    toggled: isDark,
                    child: Switch(
                      value: isDark,
                      onChanged: (value) {
                        context.read<ThemeBloc>().add(ToggleThemeEvent());
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
