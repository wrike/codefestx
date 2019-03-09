import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:codefest/src/components/layout/menu_item.dart';

@Component(
  selector: 'layout',
  styleUrls: [
    'package:angular_components/app_layout/layout.scss.css',
    'layout.css',
  ],
  templateUrl: 'layout.html',
  directives: [
    NgFor,
    MaterialSpinnerComponent,
    DeferredContentDirective,
    MaterialButtonComponent,
    MaterialIconComponent,
    MaterialTemporaryDrawerComponent,
    MaterialToggleComponent,
    MaterialListComponent,
    MaterialListItemComponent,
    MaterialButtonComponent,
    MaterialIconComponent,
  ],
  providers: [],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
  exports: [
    MenuItem,
  ]
)
class LayoutComponent {
  @Input()
  MenuItem menu;
}
