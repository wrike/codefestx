import 'package:angular/angular.dart';
import 'package:codefest/src/components/layout/layout.dart';

@Component(
  selector: 'empty-container',
  styleUrls: ['empty_container.css'],
  templateUrl: 'empty_container.html',
  directives: [
    LayoutComponent,
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class EmptyContainerComponent {}
