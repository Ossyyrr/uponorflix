import 'package:flutter/material.dart';

class TitleAppBar extends StatelessWidget {
  const TitleAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'UponorFlix',
      style: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        shadows: [
          Shadow(blurRadius: 8, color: Colors.black54, offset: Offset(0, 2)),
        ],
      ),
    );
  }
}
