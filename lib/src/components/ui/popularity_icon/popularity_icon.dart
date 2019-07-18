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
  int get _lowCount => (maxPopularity / 4).round();

  int get _middleCount => (maxPopularity / 2).round();

  int get _maxCount => (maxPopularity * 3 / 4).round();

  @Input()
  int popularity = 0;

  @Input()
  int maxPopularity = 20;

  String get icon => level.toString();

  int get level {
    var out = 0;
    if (popularity >= _maxCount) {
      out = 3;
    } else if (popularity >= _middleCount) {
      out = 2;
    } else if (popularity >= _lowCount) {
      out = 1;
    }

    return out;
  }
}
