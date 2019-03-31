import 'package:meta/meta.dart';

class UpdateSelectedSectionsAction {
  final Iterable<String> sectionIds;
  final bool isCustomSectionMode;

  UpdateSelectedSectionsAction({
    @required this.sectionIds,
    @required this.isCustomSectionMode,
  });
}
