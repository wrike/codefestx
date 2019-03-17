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
  final _onSearchModeChangeStreamController = new StreamController<bool>.broadcast();
  final _onFilterStreamController = new StreamController<Null>.broadcast();

  @Input()
  bool isSearchMode = false;

  @Input()
  String searchText = '';

  @Output()
  Stream<String> get onSearch => _onSearchStreamController.stream;

  @Output()
  Stream<bool> get onSearchModeChange => _onSearchModeChangeStreamController.stream;

  @Output()
  Stream<Null> get onFilter => _onFilterStreamController.stream;

  void onSearchModeDisable() {
    _onSearchModeChangeStreamController.add(false);
  }

  void onSearchModeEnable() {
    _onSearchModeChangeStreamController.add(true);
  }

  void onFilterClick() {
    _onFilterStreamController.add(null);
  }

  void onSearchTextChange(KeyboardEvent event) {
    InputElement element = event.target;
    _onSearchStreamController.add(element.value);
  }
}
