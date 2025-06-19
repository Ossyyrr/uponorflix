import 'package:uponorflix/domain/enum/movie_category.dart';

String? validateNotEmpty(String? value, String errorMessage) {
  if (value == null || value.trim().isEmpty) {
    return errorMessage;
  }
  return null;
}

String? validateMovieNotEmpty(MovieCategory? value, String errorMessage) {
  return value == null ? errorMessage : null;
}

String? validateYoutubeUrl(
  String? value, {
  required String emptyMessage,
  required String invalidMessage,
}) {
  if (value == null || value.trim().isEmpty) {
    return emptyMessage;
  }
  final youtubeRegex = RegExp(
    r'^(https?\:\/\/)?(www\.youtube\.com|youtu\.be)\/.+$',
    caseSensitive: false,
  );
  if (!youtubeRegex.hasMatch(value)) {
    return invalidMessage;
  }
  return null;
}
