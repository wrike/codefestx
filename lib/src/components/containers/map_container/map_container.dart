import 'package:angular/angular.dart';
import 'package:codefest/src/components/containers/stateful_component.dart';
import 'package:codefest/src/components/layout/layout.dart';
import 'package:codefest/src/redux/services/store_factory.dart';

@Component(
  selector: 'map-container',
  styleUrls: ['map_container.css'],
  templateUrl: 'map_container.html',
  directives: [
    LayoutComponent,
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class MapContainerComponent extends StatefulComponent {
  MapContainerComponent(
    NgZone zone,
    ChangeDetectorRef cdr,
    StoreFactory storeFactory,
  ) : super(zone, cdr, storeFactory);
}
