import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uponorflix/domain/model/movie.dart';
import 'package:uponorflix/l10n/app_localizations.dart';
import 'package:uponorflix/presentation/detail/detail_screen.dart';
import 'package:uponorflix/presentation/home/bloc/movie_bloc.dart';
import 'package:uponorflix/presentation/movieForm/movie_form_screen.dart';
import 'package:uponorflix/presentation/utils/enum/movie_card_action.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  Future<void> _editMovie(BuildContext context) async {
    final movieBloc = context.read<MovieBloc>();
    final updatedMovie = await Navigator.of(context).push<Movie>(
      MaterialPageRoute(builder: (_) => MovieFormScreen(movie: movie)),
    );
    if (updatedMovie == null) return;
    movieBloc.add(UpdateMovie(updatedMovie));
  }

  void _deleteMovie(BuildContext context) {
    context.read<MovieBloc>().add(DeleteMovie(movie.id));
  }

  void _openDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailScreen(movie: movie)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openDetail(context),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withAlpha(80),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(4, 4),
            ),
          ],
          image: movie.imageUrl.isNotEmpty
              ? DecorationImage(
                  image: NetworkImage(movie.imageUrl),
                  fit: BoxFit.cover,
                )
              : null,
          color: Colors.grey[300],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black87],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 16,
              right: 6,
              bottom: 16,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          movie.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(color: Colors.black54, blurRadius: 4),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          movie.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            shadows: [
                              Shadow(color: Colors.black45, blurRadius: 2),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<MovieCardAction>(
                    icon: const Icon(Icons.more_vert, color: Colors.white),
                    color: Colors.grey[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onSelected: (value) {
                      if (value == MovieCardAction.edit) {
                        _editMovie(context);
                      } else if (value == MovieCardAction.delete) {
                        _deleteMovie(context);
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: MovieCardAction.edit,
                        child: Row(
                          children: [
                            Icon(Icons.edit, color: Colors.white70, size: 20),
                            SizedBox(width: 8),
                            Text(
                              AppLocalizations.of(context)!.edit,
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: MovieCardAction.delete,
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              AppLocalizations.of(context)!.delete,
                              style: TextStyle(color: Colors.redAccent),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
