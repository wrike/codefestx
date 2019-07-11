import 'package:angular/angular.dart';

@Component(
  selector: 'info-item',
  templateUrl: 'info_item.html',
  styleUrls: ['info_item.css'],
  changeDetection: ChangeDetectionStrategy.OnPush,
  preserveWhitespace: false,
)
class InfoItemComponent {
  @HostBinding('class.info-item')
  final bool isHostMarked = true;
}
