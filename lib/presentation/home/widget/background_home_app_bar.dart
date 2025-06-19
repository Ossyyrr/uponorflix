import 'package:flutter/material.dart';

class BackgroundHomeAppBar extends StatelessWidget {
  const BackgroundHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (Theme.of(context).colorScheme.brightness == Brightness.light)
          Image.asset('assets/sliver_bg.avif', fit: BoxFit.cover),
        if (Theme.of(context).colorScheme.brightness == Brightness.dark)
          Image.asset('assets/bg_appbar.avif', fit: BoxFit.cover),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black87,
                Colors.transparent,
                Theme.of(context).colorScheme.primary.withAlpha(130),
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
