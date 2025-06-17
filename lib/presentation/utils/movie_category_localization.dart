import 'package:uponorflix/domain/enum/movie_category.dart';
import 'package:uponorflix/l10n/app_localizations.dart';

String getCategoryLabel(AppLocalizations loc, MovieCategory cat) {
  switch (cat) {
    case MovieCategory.action:
      return loc.categoryAction;
    case MovieCategory.anime:
      return loc.categoryAnime;
    case MovieCategory.sciFi:
      return loc.categorySciFi;
    case MovieCategory.comedy:
      return loc.categoryComedy;
    case MovieCategory.drama:
      return loc.categoryDrama;
    case MovieCategory.horror:
      return loc.categoryHorror;
    case MovieCategory.romance:
      return loc.categoryRomance;
    case MovieCategory.documentary:
      return loc.categoryDocumentary;
    case MovieCategory.adventure:
      return loc.categoryAdventure;
    case MovieCategory.fantasy:
      return loc.categoryFantasy;
  }
}
