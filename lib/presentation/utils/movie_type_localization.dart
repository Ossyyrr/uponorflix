import 'package:flutter/material.dart';
import 'package:uponorflix/domain/enum/movie_type.dart';
import 'package:uponorflix/l10n/app_localizations.dart';

String getTipeLabel(BuildContext context, MovieType type) {
  final loc = AppLocalizations.of(context)!;
  switch (type) {
    case MovieType.movie:
      return loc.movies;
    case MovieType.series:
      return loc.series;
  }
}
