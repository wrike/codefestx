import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/components/containers/stateful_component.dart';
import 'package:codefest/src/components/layout/layout.dart';
import 'package:codefest/src/components/loader/loader.dart';
import 'package:codefest/src/components/sections/sections.dart';
import 'package:codefest/src/components/sections/sections_change_event.dart';
import 'package:codefest/src/components/ui/button/button.dart';
import 'package:codefest/src/models/section.dart';
import 'package:codefest/src/redux/actions/effects/init_action.dart';
import 'package:codefest/src/redux/actions/effects/update_selected_sections_action.dart';
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
    ButtonComponent,
  ],
  providers: [],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class SectionsContainerComponent extends StatefulComponent implements OnInit {
  final Dispatcher _dispatcher;
  final Selectors _selectors;
  final Router _router;

  Iterable<String> _selectedSectionIds = [];

  bool _isCustomSectionMode = true;

  bool hasSelection = false;

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

  String get selectedSectionCount => selectedSectionIds.isNotEmpty ? selectedSectionIds.length.toString() : '';

  Iterable<String> get selectedSectionIds => _selectors.getSelectedSectionIds(state);

  @override
  void ngOnInit() {
    _dispatcher.dispatch(InitAction());
  }

  void onApply() {
    _dispatcher.dispatch(UpdateSelectedSectionsAction(
      sectionIds: _selectedSectionIds,
      isCustomSectionMode: _isCustomSectionMode,
    ));

    _goBack();
  }

  void onClose() {
    _goBack();
  }

  void onSectionsChange(SectionsChangeEvent event) {
    _selectedSectionIds = event.sectionIds;
    _isCustomSectionMode = event.isCustomSectionMode;
  }

  void onShowApply(bool value) {
    hasSelection = value;
  }

  void _goBack() {
    _router.navigateByUrl(RoutePaths.lectures.toUrl());
  }
}
