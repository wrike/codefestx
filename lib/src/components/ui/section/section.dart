import 'dart:html';

import 'package:angular/angular.dart';

@Component(
  selector: 'cf-section',
  templateUrl: 'section.html',
  styleUrls: const ['section.css'],
  changeDetection: ChangeDetectionStrategy.OnPush,
  preserveWhitespace: false,
)
class SectionComponent {
  @HostBinding('class.section')
  final bool isHostMarked = true;

  @Input()
  bool isChecked = false;

  @Input()
  String title;
}
