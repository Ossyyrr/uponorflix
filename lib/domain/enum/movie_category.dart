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

extension MovieCategoryExtension on MovieCategory {
  String get translationKey {
    switch (this) {
      case MovieCategory.action:
        return 'categoryAction';
      case MovieCategory.anime:
        return 'categoryAnime';
      case MovieCategory.sciFi:
        return 'categorySciFi';
      case MovieCategory.comedy:
        return 'categoryComedy';
      case MovieCategory.drama:
        return 'categoryDrama';
      case MovieCategory.horror:
        return 'categoryHorror';
      case MovieCategory.romance:
        return 'categoryRomance';
      case MovieCategory.documentary:
        return 'categoryDocumentary';
      case MovieCategory.adventure:
        return 'categoryAdventure';
      case MovieCategory.fantasy:
        return 'categoryFantasy';
    }
  }
}
