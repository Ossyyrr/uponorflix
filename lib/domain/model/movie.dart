class Movie {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String trailerUrl;

  Movie({
    this.id = '',
    required this.title,
    required this.description,
    required this.imageUrl,
    this.trailerUrl = '',
  });

  factory Movie.fromJson(Map<String, dynamic> data, String id) {
    return Movie(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      trailerUrl: data['trailerUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'trailerUrl': trailerUrl,
    };
  }
}
