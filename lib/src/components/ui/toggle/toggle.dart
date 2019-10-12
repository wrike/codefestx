import 'dart:async';

import 'package:angular/angular.dart';

@Component(
  selector: 'toggle',
  templateUrl: 'toggle.html',
  styleUrls: ['toggle.css'],
  changeDetection: ChangeDetectionStrategy.OnPush,
  preserveWhitespace: false,
)
class ToggleComponent {
  final _onChange = StreamController<bool>.broadcast();

  @HostBinding('class.toggle')
  final bool isHostMarked = true;

  @Input()
  bool isChecked = false;

  @Input()
  String text;

  @Output()
  Stream get onChange => _onChange.stream;

  void onToggle() {
    _onChange.add(!isChecked);
  }
}
