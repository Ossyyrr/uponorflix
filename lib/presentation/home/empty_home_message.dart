import 'package:flutter/material.dart';

class EmptyHomeMessage extends StatelessWidget {
  const EmptyHomeMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Text('No hay películas'),
        ),
      ),
    );
  }
}
