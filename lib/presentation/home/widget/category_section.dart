import 'package:flutter/material.dart';
import 'package:uponorflix/domain/enum/movie_category.dart';
import 'package:uponorflix/domain/model/movie.dart';
import 'package:uponorflix/l10n/app_localizations.dart';
import 'package:uponorflix/presentation/utils/movie_category_localization.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key, required this.entry});
  final MapEntry<MovieCategory, List<Movie>> entry;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
        child: Text(
          getCategoryLabel(loc, entry.key),
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
