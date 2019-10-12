import 'package:angular/angular.dart';
import 'package:angular/security.dart';

@Component(
  selector: 'empty-state',
  styleUrls: ['empty_state.css'],
  templateUrl: 'empty_state.html',
  directives: [],
  preserveWhitespace: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class EmptyStateComponent {
  DomSanitizationService _sanitizer;

  EmptyStateComponent(this._sanitizer);

  @Input()
  String title;

  @Input()
  String message;

  @Input()
  String icon;

  SafeHtml get safeIcon => _sanitizer.bypassSecurityTrustHtml(icon);
}
