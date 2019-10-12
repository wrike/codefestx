import 'package:angular/angular.dart';

@Component(
  selector: 'event-time',
  templateUrl: 'event_time.html',
  styleUrls: ['event_time.css'],
  directives: [
    NgFor,
    NgIf,
  ],
  changeDetection: ChangeDetectionStrategy.OnPush,
  preserveWhitespace: false,
)
class EventTimeComponent {
  @Input()
  String startTime;

  @Input()
  String endTime;

  bool get hasEndTime => endTime != null;
}
