import 'package:flutter/material.dart';
import 'package:uponorflix/layout/home/home_screen.dart';
import 'package:uponorflix/layout/utils/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UponorFlix',
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      home: const HomeScreen(title: 'UponorFlix'),
    );
  }
}
