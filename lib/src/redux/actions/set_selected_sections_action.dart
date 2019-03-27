import 'package:meta/meta.dart';

class SetSelectedSectionsAction {
  final Iterable<String> sectionIds;
  final bool isCustomSectionMode;

  SetSelectedSectionsAction({
    @required this.sectionIds,
    @required this.isCustomSectionMode,
  });
}
