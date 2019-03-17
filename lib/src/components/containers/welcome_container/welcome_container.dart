import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/components/sections/sections.dart';
import 'package:codefest/src/components/containers/stateful_component.dart';
import 'package:codefest/src/models/section.dart';
import 'package:codefest/src/redux/actions/change_selected_sections_action.dart';
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
  ],
  providers: [],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class WelcomeContainerComponent extends StatefulComponent {
  final Dispatcher _dispatcher;
  final Selectors _selectors;
  final Router _router;

  WelcomeContainerComponent(
      NgZone zone,
      ChangeDetectorRef cdr,
      StoreFactory storeFactory,
      this._dispatcher,
      this._selectors,
      this._router,
      ) : super(zone, cdr, storeFactory);

  Iterable<Section> get sections => _selectors.getSections(state);

  Iterable<String> selectedSectionIds = [];

  void onClose() {
    _navigateToLectures();
  }

  void onApply() {
    _dispatcher.dispatch(new ChangeSelectedSectionsAction(sectionIds: selectedSectionIds));
    _navigateToLectures();
  }

  void onSectionsChange(Iterable<String> sectionIds) {
    selectedSectionIds = sectionIds;
  }
  
  void _navigateToLectures() {
    _router.navigate(RoutePaths.lectures.toUrl());
  }
}
