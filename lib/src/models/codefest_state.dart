import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:codefest/src/models/lecture.dart';
import 'package:codefest/src/models/location.dart';
import 'package:codefest/src/models/speaker.dart';

part 'codefest_state.g.dart';

abstract class CodefestState implements Built<CodefestState, CodefestStateBuilder> {

  factory CodefestState([void updates(CodefestStateBuilder b)]) = _$CodefestState;

  CodefestState._();

  BuiltList<Speaker> get speakers;

  BuiltList<Lecture> get lectures;

  BuiltList<Location> get locations;

  bool get isReady;

  bool get isLoaded;

  bool get isError;
}
