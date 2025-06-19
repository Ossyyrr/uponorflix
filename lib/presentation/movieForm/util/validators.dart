import 'package:uponorflix/domain/enum/movie_category.dart';

String? validateNotEmpty(String? value, String errorMessage) {
  if (value == null || value.isEmpty) {
    return errorMessage;
  }
  return null;
}

String? validateMovieNotEmpty(MovieCategory? value, String errorMessage) {
  return value == null ? errorMessage : null;
}

String? validateYoutubeUrl(
  String? value, {
  String? emptyMessage,
  String? invalidMessage,
}) {
  if (value == null || value.isEmpty) {
    return emptyMessage ?? 'Ingrese un enlace de YouTube';
  }
  final youtubeRegex = RegExp(
    r'^(https?\:\/\/)?(www\.youtube\.com|youtu\.be)\/.+$',
    caseSensitive: false,
  );
  if (!youtubeRegex.hasMatch(value)) {
    return invalidMessage ?? 'Ingrese una URL válida de YouTube';
  }
  return null;
}
