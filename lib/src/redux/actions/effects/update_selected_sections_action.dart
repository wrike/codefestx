import 'package:codefest/src/models/_types.dart';
import 'package:meta/meta.dart';

class UpdateSelectedSectionsAction {
  final Iterable<String> sectionIds;
  final Iterable<LanguageType> languages;
  final bool isCustomSectionMode;

  UpdateSelectedSectionsAction({
    @required this.sectionIds,
    @required this.isCustomSectionMode,
    this.languages,
  });
}
