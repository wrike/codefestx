import 'dart:async';
import 'dart:html';

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
  final _onFavoriteChangeStreamController = new StreamController<bool>.broadcast();

  @Input()
  bool isFavorite = false;

  @Input()
  int popularity = 0;

  @Output()
  Stream<bool> get onFavoriteChange => _onFavoriteChangeStreamController.stream;

  void onStarButtonClick(MouseEvent event) {
    _onFavoriteChangeStreamController.add(!isFavorite);
    event.stopPropagation();
  }
}
