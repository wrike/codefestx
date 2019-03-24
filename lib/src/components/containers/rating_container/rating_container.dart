import 'package:angular/angular.dart';
import 'package:codefest/src/components/containers/rating_container/rating_empty_state/rating_empty_state.dart';
import 'package:codefest/src/components/layout/layout.dart';
import 'package:codefest/src/components/containers/stateful_component.dart';
import 'package:codefest/src/models/lecture.dart';
import 'package:codefest/src/redux/actions/init_action.dart';
import 'package:codefest/src/redux/selectors/selectors.dart';
import 'package:codefest/src/redux/services/dispatcher.dart';
import 'package:codefest/src/redux/services/store_factory.dart';

@Component(
  selector: 'rating-container',
  styleUrls: ['rating_container.css'],
  templateUrl: 'rating_container.html',
  directives: [
    NgIf,
    NgFor,
    LayoutComponent,
    RatingEmptyStateComponent,
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class RatingContainerComponent extends StatefulComponent implements OnInit {
  final Selectors _selectors;
  final Dispatcher _dispatcher;

  RatingContainerComponent(
    NgZone zone,
    ChangeDetectorRef cdr,
    StoreFactory storeFactory,
    this._selectors,
    this._dispatcher,
  ) : super(zone, cdr, storeFactory);

  Iterable<Lecture> get lectures => _selectors.getRatingSortedLectures(state);

  @override
  void ngOnInit() {
    _dispatcher.dispatch(InitAction());
  }
}
