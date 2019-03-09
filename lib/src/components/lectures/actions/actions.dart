import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

@Component(
  selector: 'actions',
  styleUrls: ['actions.css'],
  templateUrl: 'actions.html',
  directives: [
    NgIf,
    MaterialButtonComponent,
    MaterialIconComponent,
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class ActionsComponent {
  bool isStarChecked = false;

  void onStarButtonClick(MouseEvent event) {
    isStarChecked = !isStarChecked;
    event.stopPropagation();
  }
}
