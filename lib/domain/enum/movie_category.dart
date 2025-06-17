enum MovieCategory {
  action,
  anime,
  sciFi,
  comedy,
  drama,
  horror,
  romance,
  documentary,
  adventure,
  fantasy,
}

MovieCategory? movieCategoryFromString(String? category) {
  if (category == null) return null;
  try {
    return MovieCategory.values.firstWhere(
      (e) => e.name.toLowerCase() == category.trim().toLowerCase(),
    );
  } catch (_) {
    return null;
  }
}
