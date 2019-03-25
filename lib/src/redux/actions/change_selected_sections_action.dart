import 'package:meta/meta.dart';

class ChangeSelectedSectionsAction {
  final Iterable<String> sectionIds;

  ChangeSelectedSectionsAction({
    @required this.sectionIds,
  });
}
