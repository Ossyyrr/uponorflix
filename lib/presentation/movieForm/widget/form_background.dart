import 'package:flutter/material.dart';

class FormBackground extends StatelessWidget {
  const FormBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary.withAlpha(217),
            colorScheme.tertiary.withAlpha(179),
            colorScheme.surfaceBright.withAlpha(204),
          ],
          stops: const [0.0, 0.7, 1.0],
        ),
      ),
    );
  }
}
