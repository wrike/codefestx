import 'package:codefest/src/redux/state/user_state.dart';
import 'package:meta/meta.dart';

class FilterLecturesAction {
  final FilterTypeEnum filterType;

  FilterLecturesAction({
    @required this.filterType,
  });
}
