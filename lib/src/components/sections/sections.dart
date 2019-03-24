import 'dart:async';

import 'package:angular/angular.dart';
import 'package:codefest/src/models/section.dart';
import 'package:codefest/src/components/ui/section/section.dart';

@Component(
  selector: 'sections',
  styleUrls: ['sections.css'],
  templateUrl: 'sections.html',
  directives: [
    NgFor,
    SectionComponent
  ],
  providers: [],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class SectionsComponent {
  @HostBinding('class.sections')
  final bool isHostMarked = true;

  @Input()
  Iterable<Section> mainSections = [];

  @Input()
  Iterable<Section> customSections = [];

  @Input()
  Iterable<String> selectedSectionIds = [];

  final _onSectionsChange = new StreamController<List<String>>.broadcast();

  @Output()
  Stream<List<String>> get onSectionsChange => _onSectionsChange.stream;

  int get selectedSectionCount => selectedSectionIds.length;

  bool isSectionSelected(Section section) => selectedSectionIds.contains(section.id);

  void onSectionClick(Section section) {
    final result = selectedSectionIds.toList();

    if (result.contains(section.id)) {
      result.remove(section.id);
    } else {
      result.add(section.id);
    }

    _onSectionsChange.add(result);
  }
}
