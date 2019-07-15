import 'package:codefest/src/models/_types.dart';
import 'package:meta/meta.dart';

class SetSelectedSectionsAction {
  final Iterable<String> sectionIds;
  final Iterable<LanguageType> languages;
  final bool isCustomSectionMode;

  SetSelectedSectionsAction({
    @required this.sectionIds,
    @required this.isCustomSectionMode,
    this.languages,
  });
}
