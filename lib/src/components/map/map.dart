import 'package:angular/angular.dart';
import 'package:codefest/src/components/layout/layout.dart';

@Component(
  selector: 'map',
  styleUrls: ['map.css'],
  templateUrl: 'map.html',
  directives: [
    LayoutComponent,
  ],
  providers: [],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class MapComponent {

}
