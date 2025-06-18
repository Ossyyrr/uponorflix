import 'package:uponorflix/domain/enum/movie_category.dart';
import 'package:uponorflix/domain/enum/movie_type.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Movie {
  final String id;
  final String title;
  final String description;
  final String trailerUrl;
  final String imageUrl;
  final MovieCategory category;
  final MovieType type;

  Movie({
    this.id = '',
    required this.title,
    required this.description,
    required this.category,
    this.trailerUrl = '',
    this.type = MovieType.movie,
  }) : imageUrl = _generateThumbnail(trailerUrl);

  static String _generateThumbnail(String trailerUrl) {
    final videoId = YoutubePlayer.convertUrlToId(trailerUrl);
    if (videoId != null && videoId.isNotEmpty) {
      return 'https://img.youtube.com/vi/$videoId/hqdefault.jpg';
    }
    return '';
  }

  factory Movie.fromJson(Map<String, dynamic> data, String id) {
    return Movie(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      category:
          movieCategoryFromString(data['category']) ?? MovieCategory.action,
      trailerUrl: data['trailerUrl'] ?? '',
      type: data['type'] == 'series' ? MovieType.series : MovieType.movie,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'trailerUrl': trailerUrl,
      'imageUrl': imageUrl,
      'category': category.name,
      'type': type == MovieType.series ? 'series' : 'movie',
    };
  }
}
