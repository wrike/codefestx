import 'dart:html';

import 'package:angular/angular.dart';
import 'package:codefest/src/components/ui/button/button.dart';
import 'package:codefest/src/components/ui/link-button/link_button.dart';
import 'package:codefest/src/components/ui/popup/popup.dart';
import 'package:codefest/src/redux/actions/new_version_action.dart';
import 'package:codefest/src/redux/services/dispatcher.dart';

@Component(
  selector: 'new-version-popup',
  templateUrl: 'new_version_popup.html',
  styleUrls: ['new_version_popup.css'],
  changeDetection: ChangeDetectionStrategy.OnPush,
  preserveWhitespace: false,
  directives: [
    PopupComponent,
    ButtonComponent,
    LinkButtonComponent,
  ],
)
class NewVersionPopupComponent {
  final Dispatcher _dispatcher;

  @Input()
  String message = 'У нас новые крутые фичи!';

  NewVersionPopupComponent(
    this._dispatcher,
  );

  void close() {
    _dispatcher.dispatch(NewVersionAction(releaseNote: ''));
  }

  void reload({bool showNotes = false}) {
    if (showNotes) {
      window.location.href = '/what/is_new';
    } else {
      window.location.reload();
    }
  }
}
