import 'package:flutter/material.dart';
import 'package:uponorflix/l10n/app_localizations.dart';

class EmptyHomeMessage extends StatelessWidget {
  const EmptyHomeMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Text(AppLocalizations.of(context)!.noMovies),
        ),
      ),
    );
  }
}
