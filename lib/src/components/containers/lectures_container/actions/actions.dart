import 'dart:async';

import 'package:angular/angular.dart';
import 'package:codefest/src/components/ui/button/button.dart';
import 'package:codefest/src/components/ui/popularity_icon/popularity_icon.dart';

@Component(
  selector: 'actions',
  styleUrls: ['actions.css'],
  templateUrl: 'actions.html',
  directives: [
    NgIf,
    ButtonComponent,
    PopularityIconComponent,
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class ActionsComponent {
  final _onFavoriteChangeStreamController = StreamController<bool>.broadcast();

  @Input()
  bool isFavorite = false;

  @Input()
  int popularity = 0;

  @Output()
  Stream<bool> get onFavoriteChange => _onFavoriteChangeStreamController.stream;

  void onStarButtonClick() {
    _onFavoriteChangeStreamController.add(!isFavorite);
  }
}
