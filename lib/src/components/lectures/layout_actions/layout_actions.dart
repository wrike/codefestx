import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:codefest/src/components/ui/text_input/text_input.dart';

@Component(
  selector: 'layout-actions',
  templateUrl: 'layout_actions.html',
  styleUrls: ['layout_actions.css'],
  directives: [
    NgIf,
    MaterialButtonComponent,
    MaterialIconComponent,
    TextInput,
  ],
  providers: [],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class LayoutActionsComponent {
  final _onSearchStreamController = new StreamController<String>.broadcast();

  bool isSearchMode = false;

  @Output()
  Stream<String> get onSearch => _onSearchStreamController.stream;

  void onSearchModeDisable() {
    isSearchMode = false;
  }

  void onSearchModeEnable() {
    isSearchMode = true;
  }

  void onSearchTextChange(KeyboardEvent event) {
    InputElement element = event.target;
    _onSearchStreamController.add(element.value);
  }
}
