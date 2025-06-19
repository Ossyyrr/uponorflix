import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uponorflix/presentation/home/bloc/movie_bloc.dart';

class MovieSearchBar extends StatefulWidget {
  const MovieSearchBar({super.key});

  @override
  State<MovieSearchBar> createState() => _MovieSearchBarState();
}

class _MovieSearchBarState extends State<MovieSearchBar> {
  final FocusNode _focusNode = FocusNode();
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double expandedWidth = MediaQuery.of(context).size.width / 2;
    const double collapsedWidth = 48;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
      height: 48,
      padding: const EdgeInsets.only(left: 16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        width: _focusNode.hasFocus ? expandedWidth : collapsedWidth,
        child: Builder(
          builder: (context) {
            final searchQuery = context.select<MovieBloc, String>(
              (bloc) => bloc.state.searchQuery,
            );
            _updateController(searchQuery);

            return TextField(
              focusNode: _focusNode,
              onChanged: (value) =>
                  context.read<MovieBloc>().add(ChangeSearchQuery(value)),
              controller: _controller,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
              decoration: InputDecoration(
                hintText: 'Buscar...',
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary.withAlpha(150),
                ),
                prefixIcon: GestureDetector(
                  onTap: () {
                    if (_focusNode.hasFocus) {
                      _focusNode.unfocus();
                    } else {
                      FocusScope.of(context).requestFocus(_focusNode);
                    }
                  },
                  child: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.primary,
                  ),
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

  void _updateController(String searchQuery) {
    if (_controller.text != searchQuery) {
      _controller.text = searchQuery;
      _controller.selection = TextSelection.collapsed(
        offset: searchQuery.length,
      );
    }
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
