import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:codefest/src/models/lecture.dart';
import 'package:codefest/src/models/location.dart';
import 'package:codefest/src/models/section.dart';
import 'package:codefest/src/models/speaker.dart';
import 'package:codefest/src/redux/state/user_state.dart';

part 'codefest_state.g.dart';

abstract class CodefestState implements Built<CodefestState, CodefestStateBuilder> {

  factory CodefestState([void updates(CodefestStateBuilder b)]) = _$CodefestState;

  CodefestState._();

  bool get isError;

  bool get isLoaded;

  bool get isReady;

  BuiltList<Lecture> get lectures;

  BuiltList<Location> get locations;

  BuiltList<Section> get sections;

  BuiltList<Speaker> get speakers;

  UserState get user;
}
