import 'dart:async';

import 'package:angular/angular.dart';
import 'package:codefest/src/components/sections/sections_change_event.dart';
import 'package:codefest/src/components/ui/button/button.dart';
import 'package:codefest/src/components/ui/section/section.dart';
import 'package:codefest/src/components/ui/toggle/toggle.dart';
import 'package:codefest/src/models/_types.dart';
import 'package:codefest/src/models/section.dart';
import 'package:collection/collection.dart' show SetEquality;

@Component(
  selector: 'sections',
  styleUrls: ['sections.css'],
  templateUrl: 'sections.html',
  directives: [
    NgIf,
    NgFor,
    SectionComponent,
    ToggleComponent,
    ButtonComponent,
  ],
  providers: [],
  exports: [
    LanguageType,
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class SectionsComponent {
  @HostBinding('class.sections')
  final bool isHostMarked = true;

  @Input()
  Iterable<Section> mainSections = [];

  bool _isCustomSectionMode = true;
  bool _isCustomSectionModeCurrent = true;

  Iterable<String> _selectedSectionIds;
  List<String> _selectedSectionIdsCurrent;
  Iterable<LanguageType> _selectedLanguages;
  List<LanguageType> _selectedLanguagesCurrent;

  final _onChange = StreamController<SectionsChangeEvent>.broadcast();

  final _onShowApply = StreamController<bool>.broadcast();

  bool isSelectionChanged = true;

  bool get isCustomSectionMode => _isCustomSectionModeCurrent;

  @Input()
  set isCustomSectionMode(bool value) {
    _isCustomSectionMode = value;
    _isCustomSectionModeCurrent = value;
  }

  @Output()
  Stream<SectionsChangeEvent> get onChange => _onChange.stream;

  @Output()
  Stream<bool> get onShowApply => _onShowApply.stream;

  int get selectedSectionCount => selectedSectionIds.length;

  Iterable<String> get selectedSectionIds => _selectedSectionIdsCurrent;

  @Input()
  set selectedSectionIds(Iterable<String> value) {
    _selectedSectionIds = value;
    _selectedSectionIdsCurrent = value.toList();
  }

  @Input()
  set selectedLanguages(Iterable<LanguageType> value) {
    _selectedLanguages = value;
    _selectedLanguagesCurrent = value.toList();
  }

  bool isSectionSelected(Section section) => selectedSectionIds.contains(section.id);

  bool isLanguageSelected(LanguageType lang) => _selectedLanguages.contains(lang);

  void onCustomSectionModeClick() {
    _isCustomSectionModeCurrent = !isCustomSectionMode;
    _onChange.add(SectionsChangeEvent(_isCustomSectionModeCurrent, _selectedSectionIdsCurrent, _selectedLanguagesCurrent));
    selectionChange();
  }

  void onSectionClick(Section section) {
    if (_selectedSectionIdsCurrent.contains(section.id)) {
      _selectedSectionIdsCurrent.remove(section.id);
    } else {
      _selectedSectionIdsCurrent.add(section.id);
    }
    _onChange.add(SectionsChangeEvent(_isCustomSectionModeCurrent, _selectedSectionIdsCurrent, _selectedLanguagesCurrent));
    selectionChange();
  }

  void onLanguageClick(LanguageType lang) {
    if (_selectedLanguagesCurrent.contains(lang)) {
      _selectedLanguagesCurrent.remove(lang);
    } else {
      _selectedLanguagesCurrent.add(lang);
    }
    _onChange.add(SectionsChangeEvent(_isCustomSectionModeCurrent, _selectedSectionIdsCurrent, _selectedLanguagesCurrent));
    selectionChange();
  }

  void selectionChange() {
    isSelectionChanged = !(const SetEquality().equals(_selectedSectionIds.toSet(), _selectedSectionIdsCurrent.toSet())
        && const SetEquality().equals(_selectedLanguages.toSet(), _selectedLanguagesCurrent.toSet())
        && _isCustomSectionMode == _isCustomSectionModeCurrent);

    _onShowApply.add(isSelectionChanged);
  }
}
