import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

@Component(
  selector: 'actions',
  styleUrls: ['actions.css'],
  templateUrl: 'actions.html',
  directives: [
    NgIf,
    MaterialButtonComponent,
    MaterialIconComponent,
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class ActionsComponent {
  final _onFavoriteChangeStreamController = new StreamController<bool>.broadcast();

  @Input()
  bool isFavorite = false;

  @Output()
  Stream<bool> get onFavoriteChange => _onFavoriteChangeStreamController.stream;

  void onStarButtonClick(MouseEvent event) {
    _onFavoriteChangeStreamController.add(!isFavorite);
    event.stopPropagation();
  }
}
