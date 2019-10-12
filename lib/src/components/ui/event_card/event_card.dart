import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:codefest/src/models/speaker.dart';

@Component(
  selector: 'event-card',
  templateUrl: 'event_card.html',
  styleUrls: ['event_card.css'],
  directives: [
    NgFor,
    NgIf,
  ],
  changeDetection: ChangeDetectionStrategy.OnPush,
  preserveWhitespace: false,
)
class EventCardComponent {
  final _onClickStreamController = StreamController<MouseEvent>.broadcast();

  @Input()
  String title;

  @Input()
  String startTime;

  @Input()
  String endTime;

  bool get hasEndTime => endTime != null;

  bool get isTimeShown => false;

  @Input()
  String description;

  @Input()
  List<Speaker> speakers = const [];

  @Input()
  @HostBinding('class.stand-out')
  bool standOut = false;

  @Input()
  bool clickable = false;

  @Output()
  Stream<MouseEvent> get onClick => _onClickStreamController.stream;

  bool get sameCompany => speakers.fold<Set<String>>(Set(), (prev, next) => prev..add(next.company)).length == 1;

  void onClickHandler(MouseEvent event) {
    _onClickStreamController.add(event);
  }
}
