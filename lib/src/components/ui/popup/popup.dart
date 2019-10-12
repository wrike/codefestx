import 'dart:async';

import 'package:angular/angular.dart';
import 'package:codefest/src/components/ui/button/button.dart';

@Component(
  selector: 'popup',
  templateUrl: 'popup.html',
  styleUrls: ['popup.css'],
  directives: [
    ButtonComponent,
  ],
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
