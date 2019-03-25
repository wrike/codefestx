// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'codefest_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CodefestState extends CodefestState {
  @override
  final bool isError;
  @override
  final bool isLoaded;
  @override
  final bool isReady;
  @override
  final String releaseNote;
  @override
  final BuiltList<Lecture> lectures;
  @override
  final BuiltList<Location> locations;
  @override
  final BuiltList<Section> sections;
  @override
  final BuiltList<Speaker> speakers;
  @override
  final UserState user;

  factory _$CodefestState([void updates(CodefestStateBuilder b)]) =>
      (new CodefestStateBuilder()..update(updates)).build();

  _$CodefestState._(
      {this.isError,
      this.isLoaded,
      this.isReady,
      this.releaseNote,
      this.lectures,
      this.locations,
      this.sections,
      this.speakers,
      this.user})
      : super._() {
    if (isError == null) {
      throw new BuiltValueNullFieldError('CodefestState', 'isError');
    }
    if (isLoaded == null) {
      throw new BuiltValueNullFieldError('CodefestState', 'isLoaded');
    }
    if (isReady == null) {
      throw new BuiltValueNullFieldError('CodefestState', 'isReady');
    }
    if (releaseNote == null) {
      throw new BuiltValueNullFieldError('CodefestState', 'releaseNote');
    }
    if (lectures == null) {
      throw new BuiltValueNullFieldError('CodefestState', 'lectures');
    }
    if (locations == null) {
      throw new BuiltValueNullFieldError('CodefestState', 'locations');
    }
    if (sections == null) {
      throw new BuiltValueNullFieldError('CodefestState', 'sections');
    }
    if (speakers == null) {
      throw new BuiltValueNullFieldError('CodefestState', 'speakers');
    }
    if (user == null) {
      throw new BuiltValueNullFieldError('CodefestState', 'user');
    }
  }

  @override
  CodefestState rebuild(void updates(CodefestStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  CodefestStateBuilder toBuilder() => new CodefestStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CodefestState &&
        isError == other.isError &&
        isLoaded == other.isLoaded &&
        isReady == other.isReady &&
        releaseNote == other.releaseNote &&
        lectures == other.lectures &&
        locations == other.locations &&
        sections == other.sections &&
        speakers == other.speakers &&
        user == other.user;
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
                                $jc($jc(0, isError.hashCode),
                                    isLoaded.hashCode),
                                isReady.hashCode),
                            releaseNote.hashCode),
                        lectures.hashCode),
                    locations.hashCode),
                sections.hashCode),
            speakers.hashCode),
        user.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CodefestState')
          ..add('isError', isError)
          ..add('isLoaded', isLoaded)
          ..add('isReady', isReady)
          ..add('releaseNote', releaseNote)
          ..add('lectures', lectures)
          ..add('locations', locations)
          ..add('sections', sections)
          ..add('speakers', speakers)
          ..add('user', user))
        .toString();
  }
}

class CodefestStateBuilder
    implements Builder<CodefestState, CodefestStateBuilder> {
  _$CodefestState _$v;

  bool _isError;
  bool get isError => _$this._isError;
  set isError(bool isError) => _$this._isError = isError;

  bool _isLoaded;
  bool get isLoaded => _$this._isLoaded;
  set isLoaded(bool isLoaded) => _$this._isLoaded = isLoaded;

  bool _isReady;
  bool get isReady => _$this._isReady;
  set isReady(bool isReady) => _$this._isReady = isReady;

  String _releaseNote;
  String get releaseNote => _$this._releaseNote;
  set releaseNote(String releaseNote) => _$this._releaseNote = releaseNote;

  ListBuilder<Lecture> _lectures;
  ListBuilder<Lecture> get lectures =>
      _$this._lectures ??= new ListBuilder<Lecture>();
  set lectures(ListBuilder<Lecture> lectures) => _$this._lectures = lectures;

  ListBuilder<Location> _locations;
  ListBuilder<Location> get locations =>
      _$this._locations ??= new ListBuilder<Location>();
  set locations(ListBuilder<Location> locations) =>
      _$this._locations = locations;

  ListBuilder<Section> _sections;
  ListBuilder<Section> get sections =>
      _$this._sections ??= new ListBuilder<Section>();
  set sections(ListBuilder<Section> sections) => _$this._sections = sections;

  ListBuilder<Speaker> _speakers;
  ListBuilder<Speaker> get speakers =>
      _$this._speakers ??= new ListBuilder<Speaker>();
  set speakers(ListBuilder<Speaker> speakers) => _$this._speakers = speakers;

  UserStateBuilder _user;
  UserStateBuilder get user => _$this._user ??= new UserStateBuilder();
  set user(UserStateBuilder user) => _$this._user = user;

  CodefestStateBuilder();

  CodefestStateBuilder get _$this {
    if (_$v != null) {
      _isError = _$v.isError;
      _isLoaded = _$v.isLoaded;
      _isReady = _$v.isReady;
      _releaseNote = _$v.releaseNote;
      _lectures = _$v.lectures?.toBuilder();
      _locations = _$v.locations?.toBuilder();
      _sections = _$v.sections?.toBuilder();
      _speakers = _$v.speakers?.toBuilder();
      _user = _$v.user?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CodefestState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CodefestState;
  }

  @override
  void update(void updates(CodefestStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$CodefestState build() {
    _$CodefestState _$result;
    try {
      _$result = _$v ??
          new _$CodefestState._(
              isError: isError,
              isLoaded: isLoaded,
              isReady: isReady,
              releaseNote: releaseNote,
              lectures: lectures.build(),
              locations: locations.build(),
              sections: sections.build(),
              speakers: speakers.build(),
              user: user.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'lectures';
        lectures.build();
        _$failedField = 'locations';
        locations.build();
        _$failedField = 'sections';
        sections.build();
        _$failedField = 'speakers';
        speakers.build();
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CodefestState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
