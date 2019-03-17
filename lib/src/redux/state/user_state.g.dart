// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FilterTypeEnum _$all = const FilterTypeEnum._('all');
const FilterTypeEnum _$favorite = const FilterTypeEnum._('favorite');
const FilterTypeEnum _$section = const FilterTypeEnum._('section');

FilterTypeEnum _$valueOf(String name) {
  switch (name) {
    case 'all':
      return _$all;
    case 'favorite':
      return _$favorite;
    case 'section':
      return _$section;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<FilterTypeEnum> _$values =
    new BuiltSet<FilterTypeEnum>(const <FilterTypeEnum>[
  _$all,
  _$favorite,
  _$section,
]);

class _$UserState extends UserState {
  @override
  final String filterSectionId;
  @override
  final FilterTypeEnum filterType;
  @override
  final bool isSearchMode;
  @override
  final String searchText;
  @override
  final BuiltList<String> selectedSectionIds;

  factory _$UserState([void updates(UserStateBuilder b)]) =>
      (new UserStateBuilder()..update(updates)).build();

  _$UserState._(
      {this.filterSectionId,
      this.filterType,
      this.isSearchMode,
      this.searchText,
      this.selectedSectionIds})
      : super._() {
    if (filterType == null) {
      throw new BuiltValueNullFieldError('UserState', 'filterType');
    }
    if (isSearchMode == null) {
      throw new BuiltValueNullFieldError('UserState', 'isSearchMode');
    }
    if (selectedSectionIds == null) {
      throw new BuiltValueNullFieldError('UserState', 'selectedSectionIds');
    }
  }

  @override
  UserState rebuild(void updates(UserStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  UserStateBuilder toBuilder() => new UserStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserState &&
        filterSectionId == other.filterSectionId &&
        filterType == other.filterType &&
        isSearchMode == other.isSearchMode &&
        searchText == other.searchText &&
        selectedSectionIds == other.selectedSectionIds;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, filterSectionId.hashCode), filterType.hashCode),
                isSearchMode.hashCode),
            searchText.hashCode),
        selectedSectionIds.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserState')
          ..add('filterSectionId', filterSectionId)
          ..add('filterType', filterType)
          ..add('isSearchMode', isSearchMode)
          ..add('searchText', searchText)
          ..add('selectedSectionIds', selectedSectionIds))
        .toString();
  }
}

class UserStateBuilder implements Builder<UserState, UserStateBuilder> {
  _$UserState _$v;

  String _filterSectionId;
  String get filterSectionId => _$this._filterSectionId;
  set filterSectionId(String filterSectionId) =>
      _$this._filterSectionId = filterSectionId;

  FilterTypeEnum _filterType;
  FilterTypeEnum get filterType => _$this._filterType;
  set filterType(FilterTypeEnum filterType) => _$this._filterType = filterType;

  bool _isSearchMode;
  bool get isSearchMode => _$this._isSearchMode;
  set isSearchMode(bool isSearchMode) => _$this._isSearchMode = isSearchMode;

  String _searchText;
  String get searchText => _$this._searchText;
  set searchText(String searchText) => _$this._searchText = searchText;

  ListBuilder<String> _selectedSectionIds;
  ListBuilder<String> get selectedSectionIds =>
      _$this._selectedSectionIds ??= new ListBuilder<String>();
  set selectedSectionIds(ListBuilder<String> selectedSectionIds) =>
      _$this._selectedSectionIds = selectedSectionIds;

  UserStateBuilder();

  UserStateBuilder get _$this {
    if (_$v != null) {
      _filterSectionId = _$v.filterSectionId;
      _filterType = _$v.filterType;
      _isSearchMode = _$v.isSearchMode;
      _searchText = _$v.searchText;
      _selectedSectionIds = _$v.selectedSectionIds?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UserState;
  }

  @override
  void update(void updates(UserStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$UserState build() {
    _$UserState _$result;
    try {
      _$result = _$v ??
          new _$UserState._(
              filterSectionId: filterSectionId,
              filterType: filterType,
              isSearchMode: isSearchMode,
              searchText: searchText,
              selectedSectionIds: selectedSectionIds.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'selectedSectionIds';
        selectedSectionIds.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UserState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
