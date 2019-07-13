import 'package:angular/angular.dart';
import 'package:codefest/src/components/ui/empty_state/empty_state.dart';

@Component(
  selector: 'search-empty-state',
  templateUrl: 'search_empty_state.html',
  directives: [
    EmptyStateComponent,
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class SearchEmptyStateComponent {}
