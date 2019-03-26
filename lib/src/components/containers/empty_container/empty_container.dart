import 'package:angular/angular.dart';
import 'package:codefest/src/components/containers/empty_container/empty_state/empty_state.dart';
import 'package:codefest/src/components/containers/stateful_component.dart';
import 'package:codefest/src/components/layout/layout.dart';
import 'package:codefest/src/redux/services/store_factory.dart';

@Component(
  selector: 'empty-container',
  styleUrls: ['empty_container.css'],
  templateUrl: 'empty_container.html',
  directives: [
    LayoutComponent,
    EmptyStateComponent,
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class EmptyContainerComponent extends StatefulComponent {
  EmptyContainerComponent(
    NgZone zone,
    ChangeDetectorRef cdr,
    StoreFactory storeFactory,
  ) : super(zone, cdr, storeFactory);
}
