class Movie {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  Movie({
    this.id = '',
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  factory Movie.fromJson(Map<String, dynamic> data, String id) {
    return Movie(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'description': description, 'imageUrl': imageUrl};
  }
}
