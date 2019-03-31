import 'package:angular/angular.dart';

@Component(
  selector: 'button[link-button]',
  template: '<ng-content></ng-content>',
  styleUrls: const ['link_button.css'],
  changeDetection: ChangeDetectionStrategy.OnPush,
  preserveWhitespace: false,
)
class LinkButtonComponent {
  @HostBinding('class.link-button')
  final bool isHostMarked = true;
}
