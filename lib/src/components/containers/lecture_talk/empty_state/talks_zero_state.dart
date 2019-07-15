import 'package:angular/angular.dart';
import 'package:codefest/src/components/ui/empty_state/empty_state.dart';

@Component(
  selector: 'talks-zero-state',
  templateUrl: 'talks_zero_state.html',
  styleUrls: ['talks_zero_state.css'],
  directives: [
    EmptyStateComponent,
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class TalksStateComponent {}
