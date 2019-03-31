import 'package:angular/angular.dart';
import 'package:codefest/src/components/ui/button/button.dart';

@Component(
  selector: 'popularity-icon',
  styleUrls: ['popularity_icon.css'],
  templateUrl: 'popularity_icon.html',
  directives: [
    NgIf,
    ButtonComponent,
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class PopularityIconComponent {
  static const _lowCount = 2;
  static const _middleCount = 5;
  static const _maxCount = 10;

  @Input()
  int popularity = 0;

  String get icon => level.toString();

  int get level {
    if (popularity > _maxCount) {
      return 3;
    } else if (popularity > _middleCount) {
      return 2;
    } else if (popularity > _lowCount) {
      return 1;
    }

    return 0;
  }
}
