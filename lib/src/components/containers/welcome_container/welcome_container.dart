import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/components/ui/button/button.dart';
import 'package:codefest/src/components/containers/stateful_component.dart';
import 'package:codefest/src/components/loader/loader.dart';
import 'package:codefest/src/components/sections/sections.dart';
import 'package:codefest/src/models/section.dart';
import 'package:codefest/src/redux/actions/change_selected_sections_action.dart';
import 'package:codefest/src/redux/actions/init_action.dart';
import 'package:codefest/src/redux/selectors/selectors.dart';
import 'package:codefest/src/redux/services/dispatcher.dart';
import 'package:codefest/src/redux/services/store_factory.dart';
import 'package:codefest/src/route_paths.dart';

@Component(
  selector: 'welcome-container',
  styleUrls: ['welcome_container.css'],
  templateUrl: 'welcome_container.html',
  directives: [
    NgFor,
    SectionsComponent,
    LoaderComponent,
    ButtonComponent,
  ],
  providers: [],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class WelcomeContainerComponent extends StatefulComponent implements OnInit {
  final Dispatcher _dispatcher;
  final Selectors _selectors;
  final Router _router;

  Iterable<String> selectedSectionIds = [];

  WelcomeContainerComponent(
    NgZone zone,
    ChangeDetectorRef cdr,
    StoreFactory storeFactory,
    this._dispatcher,
    this._selectors,
    this._router,
  ) : super(zone, cdr, storeFactory);

  bool get isReady => _selectors.isReady(state);

  Iterable<Section> get sections => _selectors.getSections(state);

  @HostBinding('class.welcome')
  final bool isHostMarked = true;

  @override
  void ngOnInit() {
    _dispatcher.dispatch(InitAction());
  }

  void onApply() {
    _dispatcher.dispatch(ChangeSelectedSectionsAction(sectionIds: selectedSectionIds));
    _navigateToLectures();
  }

  void onClose() {
    _navigateToLectures();
  }

  void onSectionsChange(Iterable<String> sectionIds) {
    selectedSectionIds = sectionIds;
  }

  void _navigateToLectures() {
    _router.navigate(RoutePaths.lectures.toUrl());
  }
}
