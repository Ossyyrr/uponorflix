import 'package:flutter/material.dart';
import 'package:uponorflix/l10n/app_localizations.dart';
import 'package:uponorflix/presentation/settings/widget/language_settings.dart';
import 'package:uponorflix/presentation/settings/widget/theme_settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.settings)),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            ThemeSettings(),
            const SizedBox(height: 16),
            LanguageSettings(),
          ],
        ),
      ),
    );
  }
}
