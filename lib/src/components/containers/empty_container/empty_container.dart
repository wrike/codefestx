import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/components/containers/stateful_component.dart';
import 'package:codefest/src/components/layout/layout.dart';
import 'package:codefest/src/components/ui/button/button.dart';
import 'package:codefest/src/components/ui/empty_state/empty_state.dart';
import 'package:codefest/src/redux/services/store_factory.dart';
import 'package:codefest/src/route_paths.dart';

@Component(
  selector: 'empty-container',
  styleUrls: ['empty_container.css'],
  templateUrl: 'empty_container.html',
  directives: [
    LayoutComponent,
    EmptyStateComponent,
    ButtonComponent,
    routerDirectives
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class EmptyContainerComponent extends StatefulComponent {
  final lecturesLink = RoutePaths.lectures.toUrl();
  Router _router;

  EmptyContainerComponent(
    NgZone zone,
    ChangeDetectorRef cdr,
    StoreFactory storeFactory,
    this._router,
  ) : super(zone, cdr, storeFactory);

  void goToLectures() {
    _router.navigateByUrl(lecturesLink);
  }
}
