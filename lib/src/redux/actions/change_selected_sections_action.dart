import 'package:meta/meta.dart';

class ChangeSelectedSectionsAction {
  final Iterable<String> sectionIds;
  final bool isCustomSectionMode;

  ChangeSelectedSectionsAction({
    @required this.sectionIds,
    @required this.isCustomSectionMode,
  });
}
