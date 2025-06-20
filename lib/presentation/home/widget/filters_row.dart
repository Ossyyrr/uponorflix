import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uponorflix/domain/enum/movie_category.dart';
import 'package:uponorflix/domain/enum/movie_type.dart';
import 'package:uponorflix/l10n/app_localizations.dart';
import 'package:uponorflix/presentation/home/bloc/movie_bloc.dart';
import 'package:uponorflix/presentation/utils/movie_category_localization.dart';
import 'package:uponorflix/presentation/utils/movie_type_localization.dart';

class FiltersRow extends StatelessWidget {
  final MovieState state;

  const FiltersRow({super.key, required this.state});

  static TextStyle getDropdownTextStyle() =>
      TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Row(
      children: [
        _TypeDropdown(state: state),
        const SizedBox(width: 16),
        _CategoryDropdown(loc: loc, state: state),
      ],
    );
  }
}

class _TypeDropdown extends StatelessWidget {
  final MovieState state;

  const _TypeDropdown({required this.state});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<MovieType?>(
      value: state.selectedType,
      dropdownColor: Theme.of(context).colorScheme.primary,
      icon: const Icon(Icons.arrow_drop_down, color: Colors.white, size: 20),
      underline: const SizedBox(),

      items: [
        DropdownMenuItem<MovieType?>(
          value: null,
          child: Text(
            AppLocalizations.of(context)!.type,
            style: FiltersRow.getDropdownTextStyle(),
          ),
        ),
        ...MovieType.values.map(
          (type) => DropdownMenuItem<MovieType?>(
            value: type,
            child: Text(
              getTipeLabel(context, type),
              style: FiltersRow.getDropdownTextStyle(),
            ),
          ),
        ),
      ],
      onChanged: (type) {
        context.read<MovieBloc>().add(ChangeTypeFilter(type));
      },
    );
  }
}

class _CategoryDropdown extends StatelessWidget {
  final AppLocalizations loc;
  final MovieState state;

  const _CategoryDropdown({required this.loc, required this.state});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<MovieCategory?>(
      value: state.selectedCategory,
      dropdownColor: Theme.of(context).colorScheme.primary,
      icon: const Icon(Icons.arrow_drop_down, color: Colors.white, size: 20),
      underline: const SizedBox(),

      items: [
        DropdownMenuItem<MovieCategory?>(
          value: null,
          child: Text(loc.categories, style: FiltersRow.getDropdownTextStyle()),
        ),
        ...MovieCategory.values.map(
          (cat) => DropdownMenuItem<MovieCategory?>(
            value: cat,
            child: Text(
              getCategoryLabel(context, cat),
              style: FiltersRow.getDropdownTextStyle(),
            ),
          ),
        ),
      ],
      onChanged: (cat) {
        context.read<MovieBloc>().add(ChangeCategoryFilter(cat));
      },
    );
  }
}
