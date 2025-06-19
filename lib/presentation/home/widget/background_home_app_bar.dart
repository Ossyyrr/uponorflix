import 'package:flutter/material.dart';

class BackgroundHomeAppBar extends StatelessWidget {
  const BackgroundHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset('assets/sliver_bg.avif', fit: BoxFit.cover),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withAlpha(60),
                Theme.of(context).colorScheme.primary.withAlpha(170),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }
}
