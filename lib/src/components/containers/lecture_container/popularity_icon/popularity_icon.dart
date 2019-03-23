import 'package:angular/angular.dart';

@Component(
  selector: 'popularity-icon',
  styleUrls: ['popularity_icon.css'],
  templateUrl: 'popularity_icon.html',
  directives: [],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class PopularityIconComponent {
  static const _middleCount = 50;
  static const _maxCount = 100;

  @Input()
  int popularity = 0;

  String get icon => level.toString();

  int get level {
    if (popularity > _maxCount) {
      return 2;
    } else if (popularity > _middleCount) {
      return 1;
    }

    return 0;
  }
}
