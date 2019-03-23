import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'user_state.g.dart';

class FilterTypeEnum extends EnumClass {
  static const FilterTypeEnum all = _$all;
  static const FilterTypeEnum favorite = _$favorite;
  static const FilterTypeEnum section = _$section;

  static BuiltSet<FilterTypeEnum> get values => _$values;

  const FilterTypeEnum._(String name) : super(name);

  static FilterTypeEnum valueOf(String name) => _$valueOf(name);
}

abstract class UserState implements Built<UserState, UserStateBuilder> {
  factory UserState([void updates(UserStateBuilder b)]) = _$UserState;

  UserState._();

  BuiltList<String> get favoriteLectureIds;

  @nullable
  String get filterSectionId;

  FilterTypeEnum get filterType;

  bool get isAuthorized;

  bool get isSearchMode;

  BuiltList<String> get likedLectureIds;

  @nullable
  String get searchText;

  BuiltList<String> get selectedSectionIds;
}
