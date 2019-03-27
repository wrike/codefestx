class SectionsChangeEvent {
  final bool isCustomSectionMode;
  final Iterable<String> sectionIds;

  SectionsChangeEvent(this.isCustomSectionMode, this.sectionIds);
}
