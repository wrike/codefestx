import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/components/containers/stateful_component.dart';
import 'package:codefest/src/components/loader/loader.dart';
import 'package:codefest/src/components/sections/sections.dart';
import 'package:codefest/src/components/ui/button/button.dart';
import 'package:codefest/src/components/ui/link-button/link_button.dart';
import 'package:codefest/src/models/section.dart';
import 'package:codefest/src/redux/actions/change_selected_sections_action.dart';
import 'package:codefest/src/redux/actions/init_action.dart';
import 'package:codefest/src/redux/selectors/selectors.dart';
import 'package:codefest/src/redux/services/dispatcher.dart';
import 'package:codefest/src/redux/services/store_factory.dart';
import 'package:codefest/src/route_paths.dart';
import 'package:codefest/src/services/auth_service.dart';

@Component(
  selector: 'welcome-container',
  styleUrls: ['welcome_container.css'],
  templateUrl: 'welcome_container.html',
  directives: [
    NgFor,
    NgIf,
    SectionsComponent,
    LoaderComponent,
    LinkButtonComponent,
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
  final AuthService _authService;

  Iterable<String> selectedSectionIds = [];

  bool isCustomSectionMode = true;

  @HostBinding('class.welcome')
  final bool isHostMarked = true;

  WelcomeContainerComponent(
    NgZone zone,
    ChangeDetectorRef cdr,
    StoreFactory storeFactory,
    this._dispatcher,
    this._selectors,
    this._router,
    this._authService,
  ) : super(zone, cdr, storeFactory);

  bool get hasSelection => selectedSectionIds.isNotEmpty;

  bool get isReady => _selectors.isReady(state);

  Iterable<Section> get mainSections => _selectors.getMainSections(state);

  @override
  void ngOnInit() {
    _authService.init();
    _dispatcher.dispatch(InitAction());
  }

  void onApply() {
    _dispatcher.dispatch(ChangeSelectedSectionsAction(
      sectionIds: selectedSectionIds,
      isCustomSectionMode: isCustomSectionMode,
    ));

    _navigateToLectures();
  }

  void onClose() {
    _navigateToLectures();
  }

  void onCustomSectionModeChange(bool value) {
    isCustomSectionMode = value;
  }

  void onSectionsChange(Iterable<String> sectionIds) {
    selectedSectionIds = sectionIds;
  }

  void _navigateToLectures() {
    _router.navigate(RoutePaths.lectures.toUrl());
  }
}
