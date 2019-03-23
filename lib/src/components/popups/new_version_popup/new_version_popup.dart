import 'dart:html';

import 'package:angular/angular.dart';
import 'package:codefest/src/components/ui/button/button.dart';
import 'package:codefest/src/components/ui/popup/popup.dart';
import 'package:codefest/src/redux/actions/new_version_action.dart';
import 'package:codefest/src/redux/services/dispatcher.dart';

@Component(
  selector: 'new-version-popup',
  templateUrl: 'new_version_popup.html',
  styleUrls: const ['new_version_popup.css'],
  changeDetection: ChangeDetectionStrategy.OnPush,
  preserveWhitespace: false,
  directives: [
    PopupComponent,
    ButtonComponent,
  ],
)
class NewVersionPopupComponent {
  final Dispatcher _dispatcher;

  NewVersionPopupComponent(
    this._dispatcher,
  );

  void close() {
    _dispatcher.dispatch(NewVersionAction(isAvailable: false));
  }

  void reload() {
    window.location.reload();
  }
}
