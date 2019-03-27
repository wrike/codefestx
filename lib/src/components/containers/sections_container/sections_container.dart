import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/components/containers/stateful_component.dart';
import 'package:codefest/src/components/layout/layout.dart';
import 'package:codefest/src/components/loader/loader.dart';
import 'package:codefest/src/components/sections/sections.dart';
import 'package:codefest/src/components/ui/button/button.dart';
import 'package:codefest/src/models/section.dart';
import 'package:codefest/src/redux/actions/change_selected_sections_action.dart';
import 'package:codefest/src/redux/actions/init_action.dart';
import 'package:codefest/src/redux/selectors/selectors.dart';
import 'package:codefest/src/redux/services/dispatcher.dart';
import 'package:codefest/src/redux/services/store_factory.dart';
import 'package:codefest/src/route_paths.dart';
import 'package:collection/collection.dart' show SetEquality;

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

  Iterable<String> selectedSectionIds;
  bool isCustomSectionMode;

  Set<String> previousSelectedSectionIdsSet;

  SectionsContainerComponent(
    NgZone zone,
    ChangeDetectorRef cdr,
    StoreFactory storeFactory,
    this._dispatcher,
    this._selectors,
    this._router,
  ) : super(zone, cdr, storeFactory);

  bool get changedSelection => !(
    const SetEquality().equals(selectedSectionIds.toSet(), previousSelectedSectionIdsSet) &&
    isCustomSectionMode == previousIsCustomSectionMode
  );

  bool get isReady => _selectors.isReady(state);

  Iterable<Section> get mainSections => _selectors.getMainSections(state);

  bool get previousIsCustomSectionMode => _selectors.getCustomSectionMode(state);

  Iterable<String> get previousSelectedSectionIds => _selectors.getSelectedSectionIds(state);

  String get selectedSectionCount => selectedSectionIds.isNotEmpty ? selectedSectionIds.length.toString() : '';

  @override
  void ngOnInit() {
    previousSelectedSectionIdsSet = previousSelectedSectionIds.toSet();
    selectedSectionIds = previousSelectedSectionIds;
    isCustomSectionMode = previousIsCustomSectionMode;

    _dispatcher.dispatch(InitAction());
  }

  void onApply() {
    _dispatcher.dispatch(ChangeSelectedSectionsAction(
      sectionIds: selectedSectionIds.toList(),
      isCustomSectionMode: isCustomSectionMode,
    ));

    _goBack();
  }

  void onClose() {
    _goBack();
  }

  void onCustomSectionModeChange(bool value) {
    isCustomSectionMode = value;
  }

  void onSectionsChange(Iterable<String> sectionIds) {
    selectedSectionIds = sectionIds;
  }

  void _goBack() {
    _router.navigateByUrl(RoutePaths.lectures.toUrl());
  }
}
