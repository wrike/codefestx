import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'user_state.g.dart';

abstract class UserState implements Built<UserState, UserStateBuilder> {
  factory UserState([void updates(UserStateBuilder b)]) = _$UserState;

  UserState._();

  BuiltList<String> get selectedSectionIds;

  @nullable
  String get searchText;
}
