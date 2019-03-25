import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/components/containers/stateful_component.dart';
import 'package:codefest/src/components/layout/layout.dart';
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
  selector: 'sections-container',
  styleUrls: ['sections_container.css'],
  templateUrl: 'sections_container.html',
  directives: [
    NgIf,
    NgFor,
    SectionsComponent,
    LoaderComponent,
    LayoutComponent,
    MaterialButtonComponent,
    MaterialIconComponent
  ],
  providers: [],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class SectionsContainerComponent extends StatefulComponent implements OnInit {
  final Dispatcher _dispatcher;
  final Selectors _selectors;
  final Router _router;

  Iterable<String> _sectionIds;
  bool _isCustomSectionMode;

  SectionsContainerComponent(
    NgZone zone,
    ChangeDetectorRef cdr,
    StoreFactory storeFactory,
    this._dispatcher,
    this._selectors,
    this._router,
  ) : super(zone, cdr, storeFactory);

  bool get isCustomSectionMode => _selectors.getCustomSectionMode(state);

  bool get isReady => _selectors.isReady(state);

  Iterable<Section> get mainSections => _selectors.getMainSections(state);

  int get selectedSectionCount => _selectors.getSelectedSectionCount(state);

  Iterable<String> get selectedSectionIds => _selectors.getSelectedSectionIds(state);

  @override
  void ngOnInit() {
    _sectionIds = selectedSectionIds;
    _isCustomSectionMode = isCustomSectionMode;

    _dispatcher.dispatch(InitAction());
  }

  void onClose() {
    _router.navigate(RoutePaths.lectures.toUrl());
  }

  void onCustomSectionModeChange(bool value) {
    _isCustomSectionMode = value;
    _dispatcher.dispatch(ChangeSelectedSectionsAction(sectionIds: _sectionIds, isCustomSectionMode: value));
  }

  void onSectionsChange(Iterable<String> sectionIds) {
    _sectionIds = sectionIds;
    _dispatcher
        .dispatch(ChangeSelectedSectionsAction(sectionIds: sectionIds, isCustomSectionMode: _isCustomSectionMode));
  }
}
