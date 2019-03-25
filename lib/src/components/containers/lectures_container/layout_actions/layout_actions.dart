import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:codefest/src/components/ui/text_input/text_input.dart';
import 'package:stream_transform/stream_transform.dart';

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

  @ViewChild('searchInput')
  TextInput searchInput;

  @Input()
  bool isSearchMode = false;

  @Input()
  String searchText = '';

  @Output()
  Stream<String> get onSearch => _onSearchStreamController.stream
      .transform(debounce(Duration(milliseconds: 300)))
      .distinct();

  @Output()
  Stream<bool> get onSearchModeChange => _onSearchModeChangeStreamController.stream;

  void onSearchModeDisable() {
    _onSearchModeChangeStreamController.add(false);
  }

  void onSearchModeEnable() {
    _onSearchModeChangeStreamController.add(true);
  }

  void onSearchTextChange() {
    _onSearchStreamController.add(searchInput.nativeElement.value);
  }
}
