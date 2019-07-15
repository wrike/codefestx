import 'package:codefest/src/models/_types.dart';

class SectionsChangeEvent {
  final bool isCustomSectionMode;
  final Iterable<String> sectionIds;
  final Iterable<LanguageType> languages;

  SectionsChangeEvent(this.isCustomSectionMode, this.sectionIds, this.languages);
}
