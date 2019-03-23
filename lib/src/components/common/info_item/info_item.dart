import 'dart:html';
import 'package:angular/angular.dart';

@Component(
  selector: 'info-item',
  templateUrl: 'info_item.html',
  styleUrls: const ['info_item.css'],
  changeDetection: ChangeDetectionStrategy.OnPush,
  preserveWhitespace: false,
)
class InfoItemComponent {
  @HostBinding('class.info-item')
  final bool isHostMarked = true;
}
