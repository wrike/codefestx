import 'dart:html';

import 'package:angular/angular.dart';

@Component(
  selector: 'button[cf-button]',
  templateUrl: 'button.html',
  styleUrls: ['button.css'],
  changeDetection: ChangeDetectionStrategy.OnPush,
  preserveWhitespace: false,
)
class ButtonComponent {
  final Element nativeElement;

  @HostBinding('class.button')
  final bool isHostMarked = true;

  ButtonComponent(this.nativeElement);
}
