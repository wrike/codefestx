// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserState extends UserState {
  @override
  final BuiltList<String> selectedSectionIds;
  @override
  final String searchText;

  factory _$UserState([void updates(UserStateBuilder b)]) =>
      (new UserStateBuilder()..update(updates)).build();

  _$UserState._({this.selectedSectionIds, this.searchText}) : super._() {
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
        selectedSectionIds == other.selectedSectionIds &&
        searchText == other.searchText;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, selectedSectionIds.hashCode), searchText.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserState')
          ..add('selectedSectionIds', selectedSectionIds)
          ..add('searchText', searchText))
        .toString();
  }
}

class UserStateBuilder implements Builder<UserState, UserStateBuilder> {
  _$UserState _$v;

  ListBuilder<String> _selectedSectionIds;
  ListBuilder<String> get selectedSectionIds =>
      _$this._selectedSectionIds ??= new ListBuilder<String>();
  set selectedSectionIds(ListBuilder<String> selectedSectionIds) =>
      _$this._selectedSectionIds = selectedSectionIds;

  String _searchText;
  String get searchText => _$this._searchText;
  set searchText(String searchText) => _$this._searchText = searchText;

  UserStateBuilder();

  UserStateBuilder get _$this {
    if (_$v != null) {
      _selectedSectionIds = _$v.selectedSectionIds?.toBuilder();
      _searchText = _$v.searchText;
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
              selectedSectionIds: selectedSectionIds.build(),
              searchText: searchText);
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
