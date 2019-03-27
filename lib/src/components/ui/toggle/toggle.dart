import 'package:angular/angular.dart';

@Component(
  selector: 'toggle',
  templateUrl: 'toggle.html',
  styleUrls: const ['toggle.css'],
  changeDetection: ChangeDetectionStrategy.OnPush,
  preserveWhitespace: false,
)
class ToggleComponent {
  @HostBinding('class.toggle')
  final bool isHostMarked = true;

  @Input()
  bool isChecked = false;

  @Input()
  String text;
}
