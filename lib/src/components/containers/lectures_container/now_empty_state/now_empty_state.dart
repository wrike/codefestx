import 'package:angular/angular.dart';
import 'package:codefest/src/components/ui/empty_state/empty_state.dart';

@Component(
  selector: 'now-empty-state',
  templateUrl: 'now_empty_state.html',
  directives: [
    EmptyStateComponent
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class NowEmptyStateComponent {}
