import 'dart:async';

import 'package:angular/angular.dart';
import 'package:codefest/src/components/ui/button/button.dart';
import 'package:codefest/src/components/ui/text_input/text_input.dart';

@Component(
  selector: 'layout-actions',
  templateUrl: 'layout_actions.html',
  styleUrls: ['layout_actions.css'],
  directives: [
    ButtonComponent,
    NgIf,
    TextInput,
  ],
  providers: [],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class LayoutActionsComponent {
  final _onSearchStreamController = StreamController<String>.broadcast();
  final _onSearchModeChangeStreamController = StreamController<bool>.broadcast();

  @ViewChild('searchInput')
  TextInput searchInput;

  @Input()
  @HostBinding('class.search-mode')
  bool isSearchMode = false;

  @Input()
  String searchText = '';

  @Output()
  Stream<String> get onSearch => _onSearchStreamController.stream;

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
