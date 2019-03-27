// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lecture.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Lecture extends Lecture {
  @override
  final String id;
  @override
  final String title;
  @override
  final LectureType type;
  @override
  final BuiltList<Speaker> speakers;
  @override
  final String description;
  @override
  final Location location;
  @override
  final Section section;
  @override
  final DateTime startTime;
  @override
  final int duration;
  @override
  final LanguageType language;
  @override
  final bool isFavorite;
  @override
  final bool isLiked;
  @override
  final int likesCount;
  @override
  final int favoritesCount;
  @override
  final bool isActual;

  factory _$Lecture([void updates(LectureBuilder b)]) =>
      (new LectureBuilder()..update(updates)).build();

  _$Lecture._(
      {this.id,
      this.title,
      this.type,
      this.speakers,
      this.description,
      this.location,
      this.section,
      this.startTime,
      this.duration,
      this.language,
      this.isFavorite,
      this.isLiked,
      this.likesCount,
      this.favoritesCount,
      this.isActual})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Lecture', 'id');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('Lecture', 'title');
    }
    if (type == null) {
      throw new BuiltValueNullFieldError('Lecture', 'type');
    }
    if (speakers == null) {
      throw new BuiltValueNullFieldError('Lecture', 'speakers');
    }
    if (description == null) {
      throw new BuiltValueNullFieldError('Lecture', 'description');
    }
    if (location == null) {
      throw new BuiltValueNullFieldError('Lecture', 'location');
    }
    if (section == null) {
      throw new BuiltValueNullFieldError('Lecture', 'section');
    }
    if (startTime == null) {
      throw new BuiltValueNullFieldError('Lecture', 'startTime');
    }
    if (duration == null) {
      throw new BuiltValueNullFieldError('Lecture', 'duration');
    }
    if (language == null) {
      throw new BuiltValueNullFieldError('Lecture', 'language');
    }
    if (isFavorite == null) {
      throw new BuiltValueNullFieldError('Lecture', 'isFavorite');
    }
    if (isLiked == null) {
      throw new BuiltValueNullFieldError('Lecture', 'isLiked');
    }
    if (likesCount == null) {
      throw new BuiltValueNullFieldError('Lecture', 'likesCount');
    }
    if (favoritesCount == null) {
      throw new BuiltValueNullFieldError('Lecture', 'favoritesCount');
    }
    if (isActual == null) {
      throw new BuiltValueNullFieldError('Lecture', 'isActual');
    }
  }

  @override
  Lecture rebuild(void updates(LectureBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  LectureBuilder toBuilder() => new LectureBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Lecture &&
        id == other.id &&
        title == other.title &&
        type == other.type &&
        speakers == other.speakers &&
        description == other.description &&
        location == other.location &&
        section == other.section &&
        startTime == other.startTime &&
        duration == other.duration &&
        language == other.language &&
        isFavorite == other.isFavorite &&
        isLiked == other.isLiked &&
        likesCount == other.likesCount &&
        favoritesCount == other.favoritesCount &&
        isActual == other.isActual;
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
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc($jc(0, id.hashCode),
                                                            title.hashCode),
                                                        type.hashCode),
                                                    speakers.hashCode),
                                                description.hashCode),
                                            location.hashCode),
                                        section.hashCode),
                                    startTime.hashCode),
                                duration.hashCode),
                            language.hashCode),
                        isFavorite.hashCode),
                    isLiked.hashCode),
                likesCount.hashCode),
            favoritesCount.hashCode),
        isActual.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Lecture')
          ..add('id', id)
          ..add('title', title)
          ..add('type', type)
          ..add('speakers', speakers)
          ..add('description', description)
          ..add('location', location)
          ..add('section', section)
          ..add('startTime', startTime)
          ..add('duration', duration)
          ..add('language', language)
          ..add('isFavorite', isFavorite)
          ..add('isLiked', isLiked)
          ..add('likesCount', likesCount)
          ..add('favoritesCount', favoritesCount)
          ..add('isActual', isActual))
        .toString();
  }
}

class LectureBuilder implements Builder<Lecture, LectureBuilder> {
  _$Lecture _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  LectureType _type;
  LectureType get type => _$this._type;
  set type(LectureType type) => _$this._type = type;

  ListBuilder<Speaker> _speakers;
  ListBuilder<Speaker> get speakers =>
      _$this._speakers ??= new ListBuilder<Speaker>();
  set speakers(ListBuilder<Speaker> speakers) => _$this._speakers = speakers;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  Location _location;
  Location get location => _$this._location;
  set location(Location location) => _$this._location = location;

  Section _section;
  Section get section => _$this._section;
  set section(Section section) => _$this._section = section;

  DateTime _startTime;
  DateTime get startTime => _$this._startTime;
  set startTime(DateTime startTime) => _$this._startTime = startTime;

  int _duration;
  int get duration => _$this._duration;
  set duration(int duration) => _$this._duration = duration;

  LanguageType _language;
  LanguageType get language => _$this._language;
  set language(LanguageType language) => _$this._language = language;

  bool _isFavorite;
  bool get isFavorite => _$this._isFavorite;
  set isFavorite(bool isFavorite) => _$this._isFavorite = isFavorite;

  bool _isLiked;
  bool get isLiked => _$this._isLiked;
  set isLiked(bool isLiked) => _$this._isLiked = isLiked;

  int _likesCount;
  int get likesCount => _$this._likesCount;
  set likesCount(int likesCount) => _$this._likesCount = likesCount;

  int _favoritesCount;
  int get favoritesCount => _$this._favoritesCount;
  set favoritesCount(int favoritesCount) =>
      _$this._favoritesCount = favoritesCount;

  bool _isActual;
  bool get isActual => _$this._isActual;
  set isActual(bool isActual) => _$this._isActual = isActual;

  LectureBuilder();

  LectureBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _title = _$v.title;
      _type = _$v.type;
      _speakers = _$v.speakers?.toBuilder();
      _description = _$v.description;
      _location = _$v.location;
      _section = _$v.section;
      _startTime = _$v.startTime;
      _duration = _$v.duration;
      _language = _$v.language;
      _isFavorite = _$v.isFavorite;
      _isLiked = _$v.isLiked;
      _likesCount = _$v.likesCount;
      _favoritesCount = _$v.favoritesCount;
      _isActual = _$v.isActual;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Lecture other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Lecture;
  }

  @override
  void update(void updates(LectureBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Lecture build() {
    _$Lecture _$result;
    try {
      _$result = _$v ??
          new _$Lecture._(
              id: id,
              title: title,
              type: type,
              speakers: speakers.build(),
              description: description,
              location: location,
              section: section,
              startTime: startTime,
              duration: duration,
              language: language,
              isFavorite: isFavorite,
              isLiked: isLiked,
              likesCount: likesCount,
              favoritesCount: favoritesCount,
              isActual: isActual);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'speakers';
        speakers.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Lecture', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
