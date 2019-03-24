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
  final String avatarPath;
  @override
  final String displayName;
  @override
  final BuiltList<String> favoriteLectureIds;
  @override
  final String filterSectionId;
  @override
  final FilterTypeEnum filterType;
  @override
  final bool isAuthorized;
  @override
  final bool isSearchMode;
  @override
  final BuiltList<String> likedLectureIds;
  @override
  final String searchText;
  @override
  final BuiltList<String> selectedSectionIds;

  factory _$UserState([void updates(UserStateBuilder b)]) =>
      (new UserStateBuilder()..update(updates)).build();

  _$UserState._(
      {this.avatarPath,
      this.displayName,
      this.favoriteLectureIds,
      this.filterSectionId,
      this.filterType,
      this.isAuthorized,
      this.isSearchMode,
      this.likedLectureIds,
      this.searchText,
      this.selectedSectionIds})
      : super._() {
    if (favoriteLectureIds == null) {
      throw new BuiltValueNullFieldError('UserState', 'favoriteLectureIds');
    }
    if (filterType == null) {
      throw new BuiltValueNullFieldError('UserState', 'filterType');
    }
    if (isAuthorized == null) {
      throw new BuiltValueNullFieldError('UserState', 'isAuthorized');
    }
    if (isSearchMode == null) {
      throw new BuiltValueNullFieldError('UserState', 'isSearchMode');
    }
    if (likedLectureIds == null) {
      throw new BuiltValueNullFieldError('UserState', 'likedLectureIds');
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
        avatarPath == other.avatarPath &&
        displayName == other.displayName &&
        favoriteLectureIds == other.favoriteLectureIds &&
        filterSectionId == other.filterSectionId &&
        filterType == other.filterType &&
        isAuthorized == other.isAuthorized &&
        isSearchMode == other.isSearchMode &&
        likedLectureIds == other.likedLectureIds &&
        searchText == other.searchText &&
        selectedSectionIds == other.selectedSectionIds;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc($jc(0, avatarPath.hashCode),
                                        displayName.hashCode),
                                    favoriteLectureIds.hashCode),
                                filterSectionId.hashCode),
                            filterType.hashCode),
                        isAuthorized.hashCode),
                    isSearchMode.hashCode),
                likedLectureIds.hashCode),
            searchText.hashCode),
        selectedSectionIds.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserState')
          ..add('avatarPath', avatarPath)
          ..add('displayName', displayName)
          ..add('favoriteLectureIds', favoriteLectureIds)
          ..add('filterSectionId', filterSectionId)
          ..add('filterType', filterType)
          ..add('isAuthorized', isAuthorized)
          ..add('isSearchMode', isSearchMode)
          ..add('likedLectureIds', likedLectureIds)
          ..add('searchText', searchText)
          ..add('selectedSectionIds', selectedSectionIds))
        .toString();
  }
}

class UserStateBuilder implements Builder<UserState, UserStateBuilder> {
  _$UserState _$v;

  String _avatarPath;
  String get avatarPath => _$this._avatarPath;
  set avatarPath(String avatarPath) => _$this._avatarPath = avatarPath;

  String _displayName;
  String get displayName => _$this._displayName;
  set displayName(String displayName) => _$this._displayName = displayName;

  ListBuilder<String> _favoriteLectureIds;
  ListBuilder<String> get favoriteLectureIds =>
      _$this._favoriteLectureIds ??= new ListBuilder<String>();
  set favoriteLectureIds(ListBuilder<String> favoriteLectureIds) =>
      _$this._favoriteLectureIds = favoriteLectureIds;

  String _filterSectionId;
  String get filterSectionId => _$this._filterSectionId;
  set filterSectionId(String filterSectionId) =>
      _$this._filterSectionId = filterSectionId;

  FilterTypeEnum _filterType;
  FilterTypeEnum get filterType => _$this._filterType;
  set filterType(FilterTypeEnum filterType) => _$this._filterType = filterType;

  bool _isAuthorized;
  bool get isAuthorized => _$this._isAuthorized;
  set isAuthorized(bool isAuthorized) => _$this._isAuthorized = isAuthorized;

  bool _isSearchMode;
  bool get isSearchMode => _$this._isSearchMode;
  set isSearchMode(bool isSearchMode) => _$this._isSearchMode = isSearchMode;

  ListBuilder<String> _likedLectureIds;
  ListBuilder<String> get likedLectureIds =>
      _$this._likedLectureIds ??= new ListBuilder<String>();
  set likedLectureIds(ListBuilder<String> likedLectureIds) =>
      _$this._likedLectureIds = likedLectureIds;

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
      _avatarPath = _$v.avatarPath;
      _displayName = _$v.displayName;
      _favoriteLectureIds = _$v.favoriteLectureIds?.toBuilder();
      _filterSectionId = _$v.filterSectionId;
      _filterType = _$v.filterType;
      _isAuthorized = _$v.isAuthorized;
      _isSearchMode = _$v.isSearchMode;
      _likedLectureIds = _$v.likedLectureIds?.toBuilder();
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
              avatarPath: avatarPath,
              displayName: displayName,
              favoriteLectureIds: favoriteLectureIds.build(),
              filterSectionId: filterSectionId,
              filterType: filterType,
              isAuthorized: isAuthorized,
              isSearchMode: isSearchMode,
              likedLectureIds: likedLectureIds.build(),
              searchText: searchText,
              selectedSectionIds: selectedSectionIds.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'favoriteLectureIds';
        favoriteLectureIds.build();

        _$failedField = 'likedLectureIds';
        likedLectureIds.build();

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
