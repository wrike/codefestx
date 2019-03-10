// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'codefest_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CodefestState extends CodefestState {
  @override
  final BuiltList<Speaker> speakers;
  @override
  final BuiltList<Lecture> lectures;
  @override
  final BuiltList<Location> locations;
  @override
  final bool isReady;
  @override
  final bool isLoaded;
  @override
  final bool isError;

  factory _$CodefestState([void updates(CodefestStateBuilder b)]) =>
      (new CodefestStateBuilder()..update(updates)).build();

  _$CodefestState._(
      {this.speakers,
      this.lectures,
      this.locations,
      this.isReady,
      this.isLoaded,
      this.isError})
      : super._() {
    if (speakers == null) {
      throw new BuiltValueNullFieldError('CodefestState', 'speakers');
    }
    if (lectures == null) {
      throw new BuiltValueNullFieldError('CodefestState', 'lectures');
    }
    if (locations == null) {
      throw new BuiltValueNullFieldError('CodefestState', 'locations');
    }
    if (isReady == null) {
      throw new BuiltValueNullFieldError('CodefestState', 'isReady');
    }
    if (isLoaded == null) {
      throw new BuiltValueNullFieldError('CodefestState', 'isLoaded');
    }
    if (isError == null) {
      throw new BuiltValueNullFieldError('CodefestState', 'isError');
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
        speakers == other.speakers &&
        lectures == other.lectures &&
        locations == other.locations &&
        isReady == other.isReady &&
        isLoaded == other.isLoaded &&
        isError == other.isError;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, speakers.hashCode), lectures.hashCode),
                    locations.hashCode),
                isReady.hashCode),
            isLoaded.hashCode),
        isError.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CodefestState')
          ..add('speakers', speakers)
          ..add('lectures', lectures)
          ..add('locations', locations)
          ..add('isReady', isReady)
          ..add('isLoaded', isLoaded)
          ..add('isError', isError))
        .toString();
  }
}

class CodefestStateBuilder
    implements Builder<CodefestState, CodefestStateBuilder> {
  _$CodefestState _$v;

  ListBuilder<Speaker> _speakers;
  ListBuilder<Speaker> get speakers =>
      _$this._speakers ??= new ListBuilder<Speaker>();
  set speakers(ListBuilder<Speaker> speakers) => _$this._speakers = speakers;

  ListBuilder<Lecture> _lectures;
  ListBuilder<Lecture> get lectures =>
      _$this._lectures ??= new ListBuilder<Lecture>();
  set lectures(ListBuilder<Lecture> lectures) => _$this._lectures = lectures;

  ListBuilder<Location> _locations;
  ListBuilder<Location> get locations =>
      _$this._locations ??= new ListBuilder<Location>();
  set locations(ListBuilder<Location> locations) =>
      _$this._locations = locations;

  bool _isReady;
  bool get isReady => _$this._isReady;
  set isReady(bool isReady) => _$this._isReady = isReady;

  bool _isLoaded;
  bool get isLoaded => _$this._isLoaded;
  set isLoaded(bool isLoaded) => _$this._isLoaded = isLoaded;

  bool _isError;
  bool get isError => _$this._isError;
  set isError(bool isError) => _$this._isError = isError;

  CodefestStateBuilder();

  CodefestStateBuilder get _$this {
    if (_$v != null) {
      _speakers = _$v.speakers?.toBuilder();
      _lectures = _$v.lectures?.toBuilder();
      _locations = _$v.locations?.toBuilder();
      _isReady = _$v.isReady;
      _isLoaded = _$v.isLoaded;
      _isError = _$v.isError;
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
              speakers: speakers.build(),
              lectures: lectures.build(),
              locations: locations.build(),
              isReady: isReady,
              isLoaded: isLoaded,
              isError: isError);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'speakers';
        speakers.build();
        _$failedField = 'lectures';
        lectures.build();
        _$failedField = 'locations';
        locations.build();
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
