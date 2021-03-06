import 'package:angular/angular.dart';

@Component(
  selector: 'tabs',
  templateUrl: 'tabs.html',
  styleUrls: ['tabs.css'],
  changeDetection: ChangeDetectionStrategy.OnPush,
  preserveWhitespace: false,
)
class TabsComponent {
  @HostBinding('class.tabs')
  final bool isHostMarked = true;
}
