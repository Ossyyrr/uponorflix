import 'package:flutter/material.dart';
import 'package:uponorflix/domain/enum/movie_type.dart';

class MovieTypeChoiceChips extends StatelessWidget {
  final MovieType selectedType;
  final ValueChanged<MovieType> onTypeChanged;

  const MovieTypeChoiceChips({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        ChoiceChip(
          showCheckmark: false,
          label: const Text('Película'),
          selected: selectedType == MovieType.movie,
          onSelected: (selected) {
            if (selected) onTypeChanged(MovieType.movie);
          },
          selectedColor: colorScheme.primary,
          backgroundColor: colorScheme.surfaceBright,
          labelStyle: TextStyle(
            color: selectedType == MovieType.movie
                ? colorScheme.onPrimary
                : colorScheme.primary,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        const SizedBox(width: 8),
        ChoiceChip(
          showCheckmark: false,
          label: const Text('Serie'),
          selected: selectedType == MovieType.series,
          onSelected: (selected) {
            if (selected) onTypeChanged(MovieType.series);
          },
          selectedColor: colorScheme.primary,
          backgroundColor: colorScheme.surfaceBright,
          labelStyle: TextStyle(
            color: selectedType == MovieType.series
                ? colorScheme.onPrimary
                : colorScheme.primary,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ],
    );
  }
}
