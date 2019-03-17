import 'package:codefest/src/redux/state/user_state.dart';

class FilterLecturesAction {
  final FilterTypeEnum filterType;
  final String filterSectionId;

  FilterLecturesAction({
    this.filterType,
    this.filterSectionId,
  });
}
