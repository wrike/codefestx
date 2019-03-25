import 'package:angular/angular.dart';
import 'package:codefest/src/models/speaker.dart';

@Component(
  selector: 'event-card',
  templateUrl: 'event_card.html',
  styleUrls: const ['event_card.css'],
  directives: [
    NgIf
  ],
  changeDetection: ChangeDetectionStrategy.OnPush,
  preserveWhitespace: false,
)
class EventCardComponent {
  @Input()
  String title;

  @Input()
  String startTime;

  @Input()
  String endTime;

  bool get hasEndTime => endTime != null;

  @Input()
  String description;

  @Input()
  Speaker speaker;

  void onClick() {}

  @HostBinding('class.event')
  final bool isHostMarked = true;
}
