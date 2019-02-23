import 'package:angular/angular.dart';
import 'package:codefest/src/models/codefest_state.dart';
import 'package:redux/redux.dart';

@Component(
  selector: 'codefest',
  styleUrls: ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: [],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class AppComponent implements OnChanges {
  final ChangeDetectorRef _cd;

  final store = new Store<CodefestState>(
    combineReducers<CodefestState>([]),
    initialState: CodefestState([], []),
  );

  AppComponent(this._cd);

  @override
  void ngOnChanges(Map<String, SimpleChange> changes) {
    store.onChange.listen((_) => _cd.markForCheck());
  }
}
