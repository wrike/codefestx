import 'package:codefest/src/redux/state/user_state.dart';
import 'package:meta/meta.dart';

class FilterLecturesAction {
  final FilterTypeEnum filterType;
  final String filterSectionId;

  FilterLecturesAction({
    @required this.filterType,
    @required this.filterSectionId,
  });
}
