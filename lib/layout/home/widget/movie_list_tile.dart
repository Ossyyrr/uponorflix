import 'package:flutter/material.dart';
import 'package:uponorflix/core/model/movie.dart';

class MovieListTile extends StatelessWidget {
  final Movie movie;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const MovieListTile({
    super.key,
    required this.movie,
    required this.onEdit,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: movie.imageUrl.isNotEmpty
          ? Image.network(
              movie.imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            )
          : const Icon(Icons.movie),
      title: Text(movie.title),
      subtitle: Text(movie.description),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: onEdit,
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: onDelete,
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
