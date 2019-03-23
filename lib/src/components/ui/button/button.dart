import 'package:angular/angular.dart';

@Component(
  selector: 'button[cf-button]',
  templateUrl: 'button.html',
  styleUrls: const ['button.css'],
  changeDetection: ChangeDetectionStrategy.OnPush,
  preserveWhitespace: false,
)
class ButtonComponent {
  @HostBinding('class.button')
  final bool isHostMarked = true;
}
