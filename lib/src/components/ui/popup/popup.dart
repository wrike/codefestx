import 'dart:async';

import 'package:angular/angular.dart';

@Component(
  selector: 'popup',
  templateUrl: 'popup.html',
  styleUrls: const ['popup.css'],
  changeDetection: ChangeDetectionStrategy.OnPush,
  preserveWhitespace: false,
)
class PopupComponent {
  final _closeController = StreamController<Null>();

  @Output()
  Stream<Null> get onClose => _closeController.stream;

  void close() {
    _closeController.add(null);
  }
}
