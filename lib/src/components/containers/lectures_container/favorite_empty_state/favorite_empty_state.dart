import 'package:angular/angular.dart';
import 'package:codefest/src/components/ui/empty_state/empty_state.dart';
import 'package:codefest/src/services/intl_service.dart';

@Component(
  selector: 'favorite-empty-state',
  templateUrl: 'favorite_empty_state.html',
  directives: [
    EmptyStateComponent,
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class FavoriteEmptyStateComponent {
  final String title = IntlService.favoriteEmptyTitle();
  final String message = IntlService.favoriteEmptyMessage();
}
