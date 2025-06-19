import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uponorflix/presentation/home/bloc/movie_bloc.dart';

class MovieSearchBar extends StatelessWidget {
  const MovieSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.only(left: 16),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        child: Builder(
          builder: (context) {
            final searchQuery = context.select<MovieBloc, String>(
              (bloc) => bloc.state.searchQuery,
            );
            return TextField(
              onChanged: (value) =>
                  context.read<MovieBloc>().add(ChangeSearchQuery(value)),
              controller: TextEditingController(text: searchQuery)
                // For correct cursor position
                ..selection = TextSelection.collapsed(
                  offset: searchQuery.length,
                ),
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
              decoration: InputDecoration(
                hintText: 'Buscar...',
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary.withAlpha(150),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.primary,
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.onPrimary,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 12,
                ),
                border: _border(context),
                enabledBorder: _border(context),
                focusedBorder: _border(context),
              ),
            );
          },
        ),
      ),
    );
  }

  OutlineInputBorder _border(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.primary,
        width: 3,
      ),
    );
  }
}
