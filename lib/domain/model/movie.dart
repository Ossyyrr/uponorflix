import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Movie {
  final String id;
  final String title;
  final String description;
  final String trailerUrl;
  final String imageUrl;

  Movie({
    this.id = '',
    required this.title,
    required this.description,
    this.trailerUrl = '',
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
      trailerUrl: data['trailerUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'trailerUrl': trailerUrl,
    };
  }
}
