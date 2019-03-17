import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

@Component(
  selector: 'loader',
  styleUrls: ['loader.css'],
  templateUrl: 'loader.html',
  directives: [
    NgIf,
    MaterialSpinnerComponent,
  ],
  providers: [],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class LoaderComponent {
  @Input()
  bool isReady;
}
